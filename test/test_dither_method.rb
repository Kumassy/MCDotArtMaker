require_relative '../lib/mc_dot_art_maker'


methods = [Magick::NoDitherMethod,Magick::RiemersmaDitherMethod,Magick::FloydSteinbergDitherMethod]

methods.each do |m|
  table = MCDotArtMaker::Table.new("test_image.jpg",m)
  table.texture_image.write "test_image_#{m}.png"
end
