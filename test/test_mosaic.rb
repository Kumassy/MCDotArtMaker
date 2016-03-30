require_relative '../lib/mc_dot_art_maker'

maker = MCDotArtMaker::Maker.new("test_image.jpg")
maker.resize_to_fit(50,50)
maker.texture_image.write "test_image_texture.png"
maker.mosaic_image.write "test_image_mosaic.png"
