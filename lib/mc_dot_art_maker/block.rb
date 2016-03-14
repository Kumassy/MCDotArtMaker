module Color
  class RGB
    def ==(other)
      @r == other.r && @g == other.g && @b == other.b
    end
    def eql?(other)
      @r.eql?(other.r) && @g.eql?(other.g) && @b.eql?(other.b)
    end
    def hash
      code = 17
      code = 37*code + @r.hash
      code = 37*code + @g.hash
      code = 37*code + @b.hash
      code
    end
  end
end

module MCDotArtMaker
  TEXTURE_SIZE = 16
  class Block
    attr_reader :name,:id,:data,:texture,:color
    # - name - ブロック名 e.g. :orange_wool
    # - id - id e.g. 35
    # - data - data e.g. 1
    # - texture - ブロックのテクスチャ
    # - color - テクスチャの平均色
    def initialize(n,i,d,r,g,b,tx)
      @name = n
      @id = i
      @data = d
      @color = Color::RGB.new(r, g, b)
      @texture = tx.resize(TEXTURE_SIZE,TEXTURE_SIZE)
    end
    def to_lab
      @color.to_lab
    end
    def to_rmagic_color
      # p "calc color :#{@color.r} #{@color.g} #{@color.b}"
      Magick::Pixel.new(@color.r*256, @color.g*256, @color.b*256)
    end

    def hash
      code = 17
      code = 37*code + @name.hash
      code = 37*code + @id.hash
      code = 37*code + @data.hash
      code = 37*code + @texture.hash
      code = 37*code + @color.hash
      code
    end
    def eql?(other)
      @name.eql?(other.name) &&
      @id.eql?(other.id) &&
      @data.eql?(other.data) &&
      @texture.eql?(other.texture) &&
      @color.eql?(other.color)
    end
  end
end
