module MCDotArtMaker
  #= マイクラドット絵のpixelにあたるもの。ブロック1つで表現する
  class Cell
    attr_reader :color
    attr_accessor :block
    # def initialize(r,g,b)
    #   @color = Color::RGB.new(r, g, b)
    # end
    def initialize(image,x,y)
      pixel = image.pixel_color(x,y)
      r = pixel.red / 256
      g = pixel.green / 256
      b = pixel.blue / 256
      @color = Color::RGB.new(r, g, b)
    end
    # def set_color(r,g,b)
    #   @color = Color::RGB.new(r, g, b)
    #   # p "set color #{r} #{g} #{b}"
    # end
    def to_lab
      @color.to_lab
    end
    def to_rmagic_color
      # p "calc color :#{@color.r} #{@color.g} #{@color.b}"
      Magick::Pixel.new(@color.r*256, @color.g*256, @color.b*256)
    end
    def comparitor
      Color::Comparison.new(@color)
    end
    # def image=(other)
    #   @image = other.resize(16,16)
    # end
  end
end
