module MCDotArtMaker
  #= ドット絵を表すクラス。Cellの集合体
  class Table
    attr_reader :width, :height, :cells
    # include Enumerable

    def initialize(filename,dither_method = RiemersmaDitherMethod)
      # モザイクにしたい元画像をセット
      if filename.instance_of? String
        @image = Magick::ImageList.new(filename).first
      elsif filename.instance_of? Magick::Image
        @image = filename
      end
      @dither_method = dither_method

      @schematic_helper = MCDotArtMaker::SchematicHelper.instance
      @schematic_helper.read File.expand_path('../seed.schematic', __FILE__)

      @calculation_count = 0 # 近似ブロック計算が終わったらインクリメント
    end
    def resize_to_fit(width, height)
      @image = @image.resize_to_fit(width, height)
    end
    def [](row,col)
      load_image unless image_loaded?
      @cells[row*@width + col]
    end
    def []=(row,col,newValue)
      load_image unless image_loaded?
      @cells[row*@width + col] = newValue
    end
    def each(size = 1)
      load_image unless image_loaded?
      @cells.each_with_index do |c,i|
        x = (i % @width) * size #列番号・横方向: x
        y = (i/@width) * size #行番号・縦方向: y
        yield c,x,y
        # cell,cellの左上のx座標 ,cellの左上のy座標
      end
    end
    def each_with_index(size = 1)
      load_image unless image_loaded?
      @cells.each_with_index do |c,i|
        x = (i % @width) * size #列番号・横方向: x
        y = (i/@width) * size #行番号・縦方向: y
        yield c,i,x,y
        # cell,cellの左上のx座標 ,cellの左上のy座標
      end
    end
    def block_ids
      load_image unless image_loaded?
      tmp = []
      each do |c|
        tmp << c.block.id
      end
      tmp
    end
    def block_data
      load_image unless image_loaded?
      tmp = []
      each do |c|
        tmp << c.block.data
      end
      tmp
    end
    def mosaic_image(size = 1)
      # モザイク化した画像を返す
      calculate

      new_image = Magick::Image.new(@width*size, @height*size){ self.background_color = "white" }
      each(size) do |c,x,y|
        idr = Magick::Draw.new
        idr.fill = c.block.to_rmagic_color
        idr.rectangle(x, y, x + size, y + size)
        idr.draw(new_image)
      end
      new_image
    end
    def calculate
      load_image unless image_loaded?
      calc_nearest_block unless calculation_done?
    end
    def reset
      load_image
    end

    def texture_image(size = TEXTURE_SIZE)
      # 近似ブロック色でのモザイク画像を返す
      calculate

      new_image = Magick::Image.new(@width*size, @height*size){ self.background_color = "white" }
      each(size) do |c,x,y|
        new_image.composite!(c.block.texture(size), x, y, Magick::OverCompositeOp)
      end
      new_image
    end

    def write_schematic(filename)
      calculate

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
      MCDotArtMaker.puts "Calc nearest block...."
      @nearest_color_cash ||= {}

      each_with_index do |cell,index|
        puts "Calculating #{index+1} of #{@cells.size}" if ((index+1) % 10000 == 0)|| (index+1 == @cells.size)
        if @nearest_color_cash.include?(cell.color)
          cell.block = @nearest_color_cash[cell.color]
        else
          comparitor = cell.comparitor
          block_distance_list = {}
          @block_list.each do |block|
            block_distance_list[block] = comparitor.compare(block.color)
          end
          nearest_block = block_distance_list.min{ |x, y| x[1] <=> y[1] }[0]  #[0]: key   [1]: value
          @nearest_color_cash[cell.color] = nearest_block
          cell.block = nearest_block

          MCDotArtMaker.puts "Cashed new color #{@nearest_color_cash.size} of #{@block_list.size}"
        end
        @calculation_count += 1
      end
      MCDotArtMaker.puts "Done!"
    end
    def calculation_done?
      @cells.size == @calculation_count
    end
    def load_image
      # - width - 絵の横方向の大きさ
      # - height - 絵の縦方向の大きさ
      # 端っこは切り捨てる
      @width = @image.columns
      @height = @image.rows
      @cells = []
      @block_list = MCDotArtMaker::BlockList.instance

      MCDotArtMaker.puts "remapping..."
      @image = @image.remap(@block_list.to_remap_image,@dither_method)
      MCDotArtMaker.puts "Done!"

      MCDotArtMaker.puts "Registering cells..."
      (@width*@height).times do |i|
        x = i % @width #列番号・横方向: x
        y = i / @width #行番号・縦方向: y
        # @cells << Cell.new(@image,x,y)
        @cells << Dot.new(@image,x,y)
      end
      MCDotArtMaker.puts "Done!"

      @calculation_count = 0
    end
    def image_loaded?
      !@cells.nil?
    end
  end
end
