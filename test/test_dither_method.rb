require_relative '../lib/mc_dot_art_maker'


methods = [Magick::NoDitherMethod,Magick::RiemersmaDitherMethod,Magick::FloydSteinbergDitherMethod]

methods.each do |m|
  table = MCDotArtMaker::Table.new("anzu.png",m)
  table.texture_image.write "anzu_#{m}.png"
end
