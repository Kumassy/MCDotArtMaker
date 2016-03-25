#
# Add some features to extern gem.
#

module Color
  class RGB
    # Add to check equality
    def ==(other)
      @r == other.r && @g == other.g && @b == other.b
    end
    # Add to use this object for hash key
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

# Add to rewrite NBT files
module NBTUtils
  module Tag
    class ByteArray
      def payload=(new_value)
        @payload = ::BinData::String.new(new_value)
      end
    end
  end
end
module NBTUtils
  module Tag
    class Int
      def payload=(new_value)
        @payload = ::BinData::Int32be.new(new_value)
      end
    end
  end
end
module NBTUtils
  module Tag
    class Short
      def payload=(new_value)
        @payload = ::BinData::Int16be.new(new_value)
      end
    end
  end
end
