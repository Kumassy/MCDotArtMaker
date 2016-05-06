module MCDotArtMaker
  class CannotModifyImageError < StandardError; end

  class Maker
    attr_reader :width, :height, :dots, :image

    def initialize(filename_or_image,dither_method: RiemersmaDitherMethod, jar_path: nil)
      @image =
        case filename_or_image
        when String
          Magick::ImageList.new(filename_or_image).first
        when Magick::Image
          filename_or_image
        end
      @dither_method = dither_method

      @schematic_helper = MCDotArtMaker::SchematicHelper.new
      @schematic_helper.read(File.expand_path('../seed.schematic', __FILE__))
      # @block_list = MCDotArtMaker::BlockList.instance
      @block_list = MCDotArtMaker::BlockList.new(jar_path)

      @calculation_count = 0
      @is_locked = false

      MCDotArtMaker::Dot.set_color_palette(@block_list)
    end
    # def resize_to_fit(width, height)
    #   check_not_locked
    #   # @image = @image.resize_to_fit(width, height)
    #   @image.resize_to_fit!(width, height)
    # end

    def manipulate
      check_not_locked
      image = yield @image
      raise(ArgumentError, "Should return Magick::Image object") unless image.class == Magick::Image
      @image = image
    end

    def calculate
      # load_image unless image_loaded?
      load_image unless image_locked?
      calc_nearest_block unless calculation_done?
      lock_image
    end

    def mosaic_image(size = 1)
      # モザイク化した画像を返す
      # calculate

      new_image = Magick::Image.new(@width*size, @height*size){ self.background_color = "white" }

      @dots.each do |c|
        idr = Magick::Draw.new
        idr.fill = c.block.to_rmagic_color
        idr.rectangle(c.x, c.y, c.x + size, c.y + size)
        idr.draw(new_image)
      end
      new_image
    end
    def texture_image(size = TEXTURE_SIZE)
      # 近似ブロック色でのモザイク画像を返す
      # calculate

      new_image = Magick::Image.new(@width*size, @height*size){ self.background_color = "white" }
      @dots.each do |c|
        new_image.composite!(c.block.texture(size), c.x*size, c.y*size, Magick::OverCompositeOp)
      end
      new_image
    end
    def write_schematic(filename)
      # calculate

      @schematic_helper.blocks = block_ids
      @schematic_helper.data = block_data
      @schematic_helper.weOffsetX = 0
      @schematic_helper.weOffsetY = 0
      @schematic_helper.weOffsetZ = 0
      @schematic_helper.weOriginX = 1
      @schematic_helper.weOriginY = 0
      @schematic_helper.weOriginZ = 0
      @schematic_helper.height = 1
      @schematic_helper.width = @width
      @schematic_helper.length  = @height
      @schematic_helper.write filename
    end

    private
    def calc_nearest_block
      # MCDotArtMaker.puts "Calc nearest block...."
      # @nearest_color_cache ||= {}
      #
      # @dots.each_with_index do |cell,index|
      #   puts "Calculating #{index+1} of #{@dots.size}" if ((index+1) % 10000 == 0)|| (index+1 == @dots.size)
      #   if @nearest_color_cache.include?(cell.color)
      #     cell.block = @nearest_color_cache[cell.color]
      #   else
      #     @nearest_color_cache[cell.color] = cell.determine_block(@block_list)
      #
      #     MCDotArtMaker.puts "Cashed new color #{@nearest_color_cache.size} of #{@block_list.size}"
      #   end
      #   @calculation_count += 1
      # end
      # MCDotArtMaker.puts "Done!"



      MCDotArtMaker.puts "Calc nearest block...."

      @dots.each_with_index do |dot,index|
        puts "Calculating #{index+1} of #{@dots.size}" if ((index+1) % 10000 == 0)|| (index+1 == @dots.size)
        dot.determine_block
        @calculation_count += 1
      end
      MCDotArtMaker.puts "Done!"
    end
    def calculation_done?
      @dots.size == @calculation_count
    end
    def load_image
      # - width - 絵の横方向の大きさ
      # - height - 絵の縦方向の大きさ
      # 端っこは切り捨てる
      @width = @image.columns
      @height = @image.rows
      @dots = []


      MCDotArtMaker.puts "remapping..."
      @image = @image.remap(@block_list.color_palette,@dither_method)
      MCDotArtMaker.puts "Done!"

      MCDotArtMaker.puts "Registering dots..."
      (@width*@height).times do |i|
        x = i % @width #列番号・横方向: x
        y = i / @width #行番号・縦方向: y
        @dots << Dot.new(@image.get_color_rgb_at(x,y),x,y)
      end
      MCDotArtMaker.puts "Done!"

      @calculation_count = 0
    end
    # def image_loaded?
    #   !@dots.nil?
    # end

    def block_ids
      # calculate

      @dots.reduce([]) do |list, cell|
        list << cell.block.id
      end
    end
    def block_data
      # calculate

      @dots.reduce([]) do |list, cell|
        list << cell.block.data
      end
    end
    def check_not_locked
      raise(CannotModifyImageError,"You cannot modifiy the image after calculation.") if @is_locked
    end
    def lock_image
      @is_locked = true
    end
    def image_locked?
      @is_locked
    end

    class << self
      def calculate_before(*_methods)
        methods = Array(_methods)
        methods.each do |method|
          alias_method("#{method}_without_calculation",method)
          define_method(method) do |*args|
            calculate
            self.send("#{method}_without_calculation",*args)
          end
        end
      end

      def generate_rmagick_delegation_methods(*_methods)
        methods = Array(_methods)
        methods.each do |method|
          define_method(method) do |*args|
            check_not_locked
            @image.send("#{method}!",*args)
          end
        end
      end
    end
    calculate_before :mosaic_image, :texture_image, :write_schematic, :block_ids, :block_data
    generate_rmagick_delegation_methods :resize_to_fit, :resize_to_fill
  end
end
