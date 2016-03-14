require_relative '../../lib/mc_dot_art_maker'

# filename = 'ankou_kaijin.png'
# table = MCDotArtMaker::Table.new(filename,1)

# table.mosaic_image.write 'mozaic.png'
# table.texture_image.write 'ankou_texture.png'
# table.write_schematic 'ankou.schematic'
# table.calculate

Dir::entries("src").reject{|e| e[0]=='.'}.each do |entry|
  table = MCDotArtMaker::Table.new("src/#{entry}")
  base = entry.split('.').first
  table.texture_image.write "output/texture/#{base}.png"
  table.mosaic_image.write "output/mosaic/#{base}.png"
  table.write_schematic "output/schematic/#{base}.schematic"
end
