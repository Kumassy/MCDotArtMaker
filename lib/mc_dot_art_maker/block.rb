module MCDotArtMaker
  class Block
    attr_reader :name,:id,:data,:color
    # - name - ブロック名 e.g. :orange_wool
    # - id - id e.g. 35
    # - data - data e.g. 1
    # - texture - ブロックのテクスチャ
    # - color - テクスチャの平均色
    def initialize(n,i,d,color,tx)
      @name = n
      @id = i
      @data = d
      @color = color
      @texture = tx.resize(TEXTURE_SIZE,TEXTURE_SIZE)
    end
    def texture(size=TEXTURE_SIZE)
      # resize if texture size is not match
      if size != TEXTURE_SIZE
        @texture.resize(size,size)
      else
        @texture
      end
    end

    def to_rmagic_color
      Magick::Pixel.new(@color.r*257, @color.g*257, @color.b*257)
    end

    def hash
      code = 17
      code = 37 * code + @name.hash
      code = 37 * code + @id.hash
      code = 37 * code + @data.hash
      code = 37 * code + @texture.hash
      code = 37 * code + @color.hash
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
