module MCDotArtMaker
  DEFAULT_DOT_SIZE = 5
  #= ドット絵を表すクラス。Cellの集合体
  class Table
    attr_reader :width, :height, :cells
    include Enumerable

    # def initialize(filename,size = DEFAULT_DOT_SIZE)
    def initialize(filename,dither_method = Magick::RiemersmaDitherMethod)
      # モザイクにしたい元画像をセット
      @image = Magick::ImageList.new(filename).first
      # - width - 絵の横方向の大きさ
      # - height - 絵の縦方向の大きさ
      # 端っこは切り捨てる
      # - size - 1Cellあたりの元の絵のpixel数。大きい方があらいドット絵になる
      # @width = @image.columns/size
      # @height = @image.rows/size
      @width = @image.columns
      @height = @image.rows
      # @size = size

      @cells = []

      @block_list = MCDotArtMaker::BlockList.instance
      # puts "quantizing..."
      # @image = @image.quantize(@block_list.size)
      # puts "Done!"
      puts "remapping..."
      @image = @image.remap(@block_list.to_remap_image,dither_method)
      puts "Done!"

      # puts "Making mosaic data..."
      puts "Registering cells..."
      (@width*@height).times do |i|
        # x = (i % @width) * size #列番号・横方向: x
        # y = (i / @width) * size #行番号・縦方向: y
        x = i % @width #列番号・横方向: x
        y = i / @width #行番号・縦方向: y
        # @cells << Cell.new(*MCDotArtMaker.calc_average_color(@image.get_pixels(x,y,size,size)))
        @cells << Cell.new(@image,x,y)
      end
      puts "Done!"


      @schematic_helper = MCDotArtMaker::SchematicHelper.instance
      # @schematic_helper.read 'mc_dot_art_maker/seed.schematic'
      @schematic_helper.read File.expand_path('../seed.schematic', __FILE__)

      @calculation_count = 0 # 近似ブロック計算が終わったらインクリメント
    end
    def [](row,col)
      @cells[row*@width + col]
    end
    def []=(row,col,newValue)
      @cells[row*@width + col] = newValue
    end
    def each(size = 1)
      @cells.each_with_index do |c,i|
        x = (i % @width) * size #列番号・横方向: x
        y = (i/@width) * size #行番号・縦方向: y
        yield c,x,y
        # cell,cellの左上のx座標 ,cellの左上のy座標
      end
    end
    def each_with_index(size = 1)
      @cells.each_with_index do |c,i|
        x = (i % @width) * size #列番号・横方向: x
        y = (i/@width) * size #行番号・縦方向: y
        yield c,i,x,y
        # cell,cellの左上のx座標 ,cellの左上のy座標
      end
    end
    def block_ids
      tmp = []
      each do |c|
        tmp << c.block.id
      end
      tmp
    end
    def block_data
      tmp = []
      each do |c|
        tmp << c.block.data
      end
      tmp
    end
    def mosaic_image
      # モザイク化した画像を返す
      calc_nearest_block unless calculation_done?

      new_image = Magick::Image.new(@width*TEXTURE_SIZE, @height*TEXTURE_SIZE){ self.background_color = "white" }
      each(TEXTURE_SIZE) do |c,x,y|
        idr = Magick::Draw.new
        # idr.fill = c.to_rmagic_color
        idr.fill = c.block.to_rmagic_color
        idr.rectangle(x, y, x + TEXTURE_SIZE, y + TEXTURE_SIZE)
        idr.draw(new_image)
      end
      new_image
    end
    def calculate
      calc_nearest_block unless calculation_done?
    end

    def texture_image
      # 近似ブロック色でのモザイク画像を返す
      calc_nearest_block unless calculation_done?

      new_image = Magick::Image.new(@width*TEXTURE_SIZE, @height*TEXTURE_SIZE){ self.background_color = "white" }
      each(TEXTURE_SIZE) do |c,x,y|
        new_image.composite!(c.block.texture, x, y, Magick::OverCompositeOp)
      end
      new_image
    end

    def write_schematic(filename)
      calc_nearest_block unless calculation_done?

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
      puts "Calc nearest block...."

      # Parallel.each_with_index(@cells, :in_processes=>4) do |cell,index|
      @nearest_color_cash ||= {}
      each_with_index do |cell,index|
        puts "Calculating #{index+1} of #{@cells.size}" if (index % 10000 == 0)|| (index == @cells.size)
        if @nearest_color_cash.include?(cell.color)
          cell.block = @nearest_color_cash[cell.color]
          # puts "Cashe hit! #{cell.color}"
        else
          # puts "New Color! #{cell.color}"
          comparitor = cell.comparitor
          block_distance_list = {}
          @block_list.each do |block|
          # Parallel.each(@block_list, :in_processes=>4) do |block|
            block_distance_list[block] = comparitor.compare(block.color)
          end
          nearest_block = block_distance_list.min{ |x, y| x[1] <=> y[1] }[0]  #[0]: key   [1]: value
          @nearest_color_cash[cell.color] = nearest_block
          cell.block = nearest_block

          puts "Cashed new color #{@nearest_color_cash.size} of #{@block_list.size}"
        end
        @calculation_count += 1
      end
      puts "Done!"
    end
    def calculation_done?
      @cells.size == @calculation_count
    end
  end
end
