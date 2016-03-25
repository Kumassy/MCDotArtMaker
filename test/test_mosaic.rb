require_relative '../lib/mc_dot_art_maker'

table = MCDotArtMaker::Table.new("test_image.jpg")
table.resize_to_fit(50,50)
table.texture_image.write "test_image_texture.png"
table.mosaic_image.write "test_image_mosaic.png"
