module MCDotArtMaker
  def self.calc_average_color(pixels)
    if pixels.size == 1
      return pixels[0].red/256, pixels[0].green/256, pixels[0].blue/256
    end
    sum_r = pixels.reduce(0) do |a,elem|
      a+elem.red/256
    end
    ave_r = sum_r/pixels.size

    sum_g = pixels.reduce(0) do |a,elem|
      a+elem.green/256
    end
    ave_g = sum_g/pixels.size

    sum_b = pixels.reduce(0) do |a,elem|
      a+elem.blue/256
    end
    ave_b = sum_b/pixels.size

    [ave_r, ave_g, ave_b]
  end
end
