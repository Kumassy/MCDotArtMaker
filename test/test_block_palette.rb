require_relative '../lib/mc_dot_art_maker'
module MCDotArtMaker
  class Maker
    attr_reader :block_list
  end
end
maker = MCDotArtMaker::Maker.new("test_image.jpg")
maker.block_list.to_remap_image.write("palette.png")
