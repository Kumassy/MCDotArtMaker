require_relative '../lib/mc_dot_art_maker'
require 'test/unit'
require "digest/md5"

class NormalConversionTest < Test::Unit::TestCase
  TMP_DIR = "images/tmp"
  class << self
    def startup
      FileUtils.rm_r TMP_DIR
      Dir.mkdir(TMP_DIR) unless Dir.exist?(TMP_DIR)
    end
  end
  def setup
    maker = MCDotArtMaker::Maker.new("images/src/test_image.jpg")
    maker.texture_image.write "images/tmp/normal_conversion_texture.png"
    maker.mosaic_image.write "images/tmp/normal_conversion_mosaic.png"
    maker.write_schematic "images/tmp/normal_conversion_schematic.schematic"
  end

  def test_block_palette
    assert_equal(Digest::MD5.file("images/sample/normal_conversion_texture.png"),
      Digest::MD5.file("images/tmp/normal_conversion_texture.png"))
    assert_equal(Digest::MD5.file("images/sample/normal_conversion_mosaic.png"),
      Digest::MD5.file("images/tmp/normal_conversion_mosaic.png"))

    # md5 values seems to be changed for every output...
    # assert_equal(Digest::MD5.file("images/sample/normal_conversion_schematic.schematic"),
    #   Digest::MD5.file("images/tmp/normal_conversion_schematic.schematic"))
  end
end
