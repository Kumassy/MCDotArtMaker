require_relative '../lib/mc_dot_art_maker'


methods = [Magick::NoDitherMethod,Magick::RiemersmaDitherMethod,Magick::FloydSteinbergDitherMethod]

methods.each do |m|
  fn = Magick::ImageList.new("test_image.jpg").first

  table = MCDotArtMaker::Table.new(fn,m)
  table.texture_image.write "test_image_#{m}.png"
end
