require_relative '../lib/mc_dot_art_maker'
require 'test/unit'
require "digest/md5"


class BlockPaletteTest < Test::Unit::TestCase
  TMP_DIR = "test/images/tmp"
  METHODS = [MCDotArtMaker::NoDitherMethod,MCDotArtMaker::RiemersmaDitherMethod,MCDotArtMaker::FloydSteinbergDitherMethod]

  class << self
    def startup
      FileUtils.rm_r TMP_DIR
      Dir.mkdir(TMP_DIR) unless Dir.exist?(TMP_DIR)
    end
  end
  def setup
    METHODS.each do |m|
      maker = MCDotArtMaker::Maker.new("test/images/src/test_image.jpg",m)
      maker.texture_image.write "test/images/tmp/dither_methods_#{m}.png"
    end
  end

  def test_dither_methods
    METHODS.each do |m|
      assert_equal(Digest::MD5.file("test/images/sample/dither_methods_#{m}.png"),
        Digest::MD5.file("test/images/tmp/dither_methods_#{m}.png"))
    end
  end
end
