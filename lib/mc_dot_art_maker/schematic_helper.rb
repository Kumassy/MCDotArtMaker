module MCDotArtMaker
  class IllegalBlockSizeError < StandardError ; end

  #= .schematicを処理するためのクラス
  # nbt_utilsをラップして書き込み機能を追加する
  class SchematicHelper
    include Singleton
    attr_reader :blocks,:data
    attr_reader :weOffsetX,:weOffsetY,:weOffsetZ
    attr_reader :weOriginX,:weOriginY,:weOriginZ
    attr_reader :height,:width,:length
    attr_reader :modified
    # @blocks: ブロックのIDデータ
    # ブロックの並び順は -Xから +X方向
    # 次に+Z方向に進んで -Xから +X方向
    # XZ平面のブロックを記述し終えたら +Y方向に1進む
    def initialize
      @file = NBTUtils::File.new
    end
    def read(filename)
      @filename = filename
      init
      @modified = false
    end
    def refresh
      init
      @modified = false
    end
    def to_s
      @tag.to_s
    end

    def blocks=(other)
      # - other - BlockID の配列
      @blocks = other
      @modified = true
    end
    def data=(other)
      # - other - Data の配列
      @data = other
      @modified = true
    end
    def weOffsetX=(other)
      @weOffsetX = other
      @modified = true
    end
    def weOffsetY=(other)
      @weOffsetY = other
      @modified = true
    end
    def weOffsetZ=(other)
      @weOffsetZ = other
      @modified = true
    end
    def weOriginX=(other)
      @weOriginX = other
      @modified = true
    end
    def weOriginY=(other)
      @weOriginY = other
      @modified = true
    end
    def weOriginZ=(other)
      @weOriginZ = other
      @modified = true
    end
    def height=(other)
      @height = other
      @modified = true
    end
    def width=(other)
      @width = other
      @modified = true
    end
    def length=(other)
      @length = other
      @modified = true
    end
    def write(name)
      raise(IllegalBlockSizeError,"Blocks or Data size doesn't match length*width*height") unless verify

      @tag.find_tag("Blocks").payload = to_nbt_block
      @tag.find_tag("Data").payload = to_nbt_data
      @tag.find_tag("WEOffsetX").payload = @weOffsetX
      @tag.find_tag("WEOffsetY").payload = @weOffsetY
      @tag.find_tag("WEOffsetZ").payload = @weOffsetZ
      @tag.find_tag("WEOriginX").payload = @weOriginX
      @tag.find_tag("WEOriginY").payload = @weOriginY
      @tag.find_tag("WEOriginZ").payload = @weOriginZ

      @tag.find_tag("Height").payload = @height
      @tag.find_tag("Width").payload = @width
      @tag.find_tag("Length").payload = @length

      @file.write(name, @tag, true)
      @modified = false
    end

    private
    def init
      # .schematicを読みこんで、プロパティを初期化
      @tag = @file.read(@filename)

      @blocks = []
      @tag.find_tag("Blocks").payload.to_s.split("").each do |s|
        # p blockdata[s.unpack("H*")[0].hex]
        @blocks << s.unpack("H*")[0].hex
      end
      @data = []
      @tag.find_tag("Data").payload.to_s.split("").each do |s|
        # p blockdata[s.unpack("H*")[0].hex]
        @data << s.unpack("H*")[0].hex
      end

      @weOffsetX = @tag.find_tag("WEOffsetX").payload
      @weOffsetY = @tag.find_tag("WEOffsetY").payload
      @weOffsetZ = @tag.find_tag("WEOffsetZ").payload
      @weOriginX = @tag.find_tag("WEOriginX").payload
      @weOriginY = @tag.find_tag("WEOriginY").payload
      @weOriginZ = @tag.find_tag("WEOriginZ").payload

      @height = @tag.find_tag("Height").payload
      @width = @tag.find_tag("Width").payload
      @length = @tag.find_tag("Length").payload
    end
    def to_nbt_block
      [@blocks.map{|b| b.to_s(16).rjust(2,"0") }.join].pack("H*")
    end
    def to_nbt_data
      [@data.map{|d| d.to_s(16).rjust(2,"0") }.join].pack("H*")
    end
    def verify
      # ブロック数とデータ数が等しいか、Width * Length * height がブロック数と等しいか計算
      size = @width * @height * @length
      (@blocks.size == size) && (@data.size == size)
    end
  end
end
