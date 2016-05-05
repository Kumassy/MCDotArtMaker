module MCDotArtMaker
  class InternalError < StandardError; end
  class Dot
    attr_reader :color, :x, :y
    attr_accessor :block

    def initialize(color, x, y)
      @color = color
      @x = x
      @y = y
    end

    def to_rmagic_color
      # p "calc color :#{@color.r} #{@color.g} #{@color.b}"
      Magick::Pixel.new(@color.r*257, @color.g*257, @color.b*257)
    end

    # def determine_block(block_list)
    def determine_block
      # comparitor = self.comparitor
      # block_distance_list = {}
      # block_list.each do |block|
      #   block_distance_list[block] = comparitor.compare(block.color)
      # end
      # nearest_block = block_distance_list.min{ |x, y| x[1] <=> y[1] }[0]  #[0]: key   [1]: value
      #
      # self.block = nearest_block
      # nearest_block


      # clocest_block = block_list.select{ |block|
      #   comparitor.compare(block.color) == 0
      # }.first
      # raise(InternalError, "An error occured while determine clocest block...") if clocest_block.nil?
      #
      # @block = clocest_block


      @block = self.class.color_block_table[@color]
    end

    private
    # def comparitor
    #   @comparitor || begin
    #     @comparitor = Color::Comparison.new(@color)
    #   end
    # end

    class << self
      def set_color_palette(cp)
        @block_list = cp

        @color_block_table = @block_list.reduce({}) do |hash, block|
          hash.store(block.color,block)
          hash
        end
      end
      def color_block_table
        @color_block_table
      end
    end
  end
end
