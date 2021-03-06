require_relative '../../lib/mc_dot_art_maker'

Dir::entries("src").reject{|e| e[0]=='.'}.each do |entry|
  # table = MCDotArtMaker::Table.new("src/#{entry}")
  # base = entry.split('.').first
  #
  # table.resize_to_fit(500,500)
  # table.texture_image.write "output/texture/#{base}.png"
  # table.mosaic_image.write "output/mosaic/#{base}.png"
  # table.write_schematic "output/schematic/#{base}.schematic"



  maker = MCDotArtMaker::Maker.new("src/#{entry}")
  base = entry.split('.').first

  maker.resize_to_limit(500,500)
  maker.texture_image.write "output/texture/#{base}.png"
  maker.mosaic_image.write "output/mosaic/#{base}.png"
  maker.write_schematic "output/schematic/#{base}.schematic"
end
