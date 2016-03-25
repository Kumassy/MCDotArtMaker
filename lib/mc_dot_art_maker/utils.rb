module MCDotArtMaker
  def self.calc_average_color(arg)
    pixels = nil
    if arg.instance_of? Magick::Image or arg.instance_of? Magick::ImageList
      pixels = arg.get_pixels(0,0,arg.columns,arg.rows)
    elsif arg.instance_of? Array
      pixels = arg
    end

    if pixels.size == 1
      return pixels[0].red/257, pixels[0].green/257, pixels[0].blue/257
    end
    sum_r = pixels.reduce(0) do |a,elem|
      a+elem.red/257
    end
    ave_r = sum_r/pixels.size

    sum_g = pixels.reduce(0) do |a,elem|
      a+elem.green/257
    end
    ave_g = sum_g/pixels.size

    sum_b = pixels.reduce(0) do |a,elem|
      a+elem.blue/257
    end
    ave_b = sum_b/pixels.size

    [ave_r, ave_g, ave_b]
  end

  def self.puts(*args)
    Kernel.puts *args if DEBUG
  end
end
