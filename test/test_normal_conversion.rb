require_relative '../lib/mc_dot_art_maker'
require 'test/unit'
require "digest/md5"

module MCDotArtMaker
  class Maker
    public :block_data
    public :block_ids
  end
end

class NormalConversionTest < Test::Unit::TestCase
  TMP_DIR = "test/images/tmp"
  class << self
    def startup
      # FileUtils.rm_r TMP_DIR
      # Dir.mkdir(TMP_DIR) unless Dir.exist?(TMP_DIR)
    end
  end
  def setup
    FileUtils.rm_r TMP_DIR
    Dir.mkdir(TMP_DIR) unless Dir.exist?(TMP_DIR)

    maker = MCDotArtMaker::Maker.new("test/images/src/test_image.jpg")
    maker.texture_image.write "test/images/tmp/normal_conversion_texture.png"
    maker.mosaic_image.write "test/images/tmp/normal_conversion_mosaic.png"
    maker.write_schematic "test/images/tmp/normal_conversion_schematic.schematic"

    maker = MCDotArtMaker::Maker.new(Magick::ImageList.new("test/images/src/test_image.jpg").first)
    maker.texture_image.write "test/images/tmp/normal_conversion_texture_with_magick__image.png"
    maker.mosaic_image.write "test/images/tmp/normal_conversion_mosaic_with_magick__image.png"

  end

  def test_normal_conversion
    assert_equal(Digest::MD5.file("test/images/sample/normal_conversion_texture.png"),
      Digest::MD5.file("test/images/tmp/normal_conversion_texture.png"))
    assert_equal(Digest::MD5.file("test/images/sample/normal_conversion_mosaic.png"),
      Digest::MD5.file("test/images/tmp/normal_conversion_mosaic.png"))
    refute_equal(Digest::MD5.file("test/images/sample/normal_conversion_mosaic.png"),
      Digest::MD5.file("test/images/sample/normal_conversion_texture.png"))
    refute_equal(Digest::MD5.file("test/images/tmp/normal_conversion_mosaic.png"),
      Digest::MD5.file("test/images/tmp/normal_conversion_texture.png"))

    # md5 values seems to be changed for every output...
    # assert_equal(Digest::MD5.file("test/images/sample/normal_conversion_schematic.schematic"),
    #   Digest::MD5.file("test/images/tmp/normal_conversion_schematic.schematic"))

  end

  def test_normal_conversion_with_image_arg
    assert_equal(Digest::MD5.file("test/images/sample/normal_conversion_texture.png"),
      Digest::MD5.file("test/images/tmp/normal_conversion_texture_with_magick__image.png"))
    assert_equal(Digest::MD5.file("test/images/sample/normal_conversion_mosaic.png"),
      Digest::MD5.file("test/images/tmp/normal_conversion_mosaic_with_magick__image.png"))
      refute_equal(Digest::MD5.file("test/images/sample/normal_conversion_mosaic.png"),
        Digest::MD5.file("test/images/sample/normal_conversion_texture.png"))
      refute_equal(Digest::MD5.file("test/images/tmp/normal_conversion_mosaic_with_magick__image.png"),
        Digest::MD5.file("test/images/tmp/normal_conversion_texture_with_magick__image.png"))
  end

  def test_schematic
    sample_schematic_helper = MCDotArtMaker::SchematicHelper.new
    tmp_schematic_helper = MCDotArtMaker::SchematicHelper.new

    sample_schematic_helper.read("test/images/sample/normal_conversion_schematic.schematic")
    tmp_schematic_helper.read("test/images/tmp/normal_conversion_schematic.schematic")

    assert_equal(sample_schematic_helper.blocks, tmp_schematic_helper.blocks)
    assert_equal(sample_schematic_helper.data, tmp_schematic_helper.data)

    assert_equal(sample_schematic_helper.weOffsetX, tmp_schematic_helper.weOffsetX)
    assert_equal(sample_schematic_helper.weOffsetY, tmp_schematic_helper.weOffsetY)
    assert_equal(sample_schematic_helper.weOffsetZ, tmp_schematic_helper.weOffsetZ)
    assert_equal(sample_schematic_helper.weOriginX, tmp_schematic_helper.weOriginX)
    assert_equal(sample_schematic_helper.weOriginY, tmp_schematic_helper.weOriginY)
    assert_equal(sample_schematic_helper.weOriginZ, tmp_schematic_helper.weOriginZ)

    assert_equal(sample_schematic_helper.height, tmp_schematic_helper.height)
    assert_equal(sample_schematic_helper.width, tmp_schematic_helper.width)
    assert_equal(sample_schematic_helper.length, tmp_schematic_helper.length)
  end
end
