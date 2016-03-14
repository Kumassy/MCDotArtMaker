require_relative '../lib/mc_dot_art_maker'
module MCDotArtMaker
  class Table
    attr_reader :block_list
  end
end
table = MCDotArtMaker::Table.new("anzu.png")
table.block_list.to_remap_image.write("palette.png")
