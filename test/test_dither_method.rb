require_relative '../lib/mc_dot_art_maker'


methods = [MCDotArtMaker::NoDitherMethod,MCDotArtMaker::RiemersmaDitherMethod,MCDotArtMaker::FloydSteinbergDitherMethod]

methods.each do |m|
  fn = Magick::ImageList.new("test_image.jpg").first

  maker = MCDotArtMaker::Maker.new(fn,m)
  maker.texture_image.write "test_image_#{m}.png"
end
