require_relative '../lib/mc_dot_art_maker'
require 'test/unit'
require "digest/md5"

module MCDotArtMaker
  class Maker
    attr_reader :block_list
  end
end

class BlockPaletteTest < Test::Unit::TestCase
  TMP_DIR = "images/tmp"
  class << self
    def startup
      FileUtils.rm_r TMP_DIR
      Dir.mkdir(TMP_DIR) unless Dir.exist?(TMP_DIR)
    end
  end
  def setup
    maker = MCDotArtMaker::Maker.new("images/src/test_image.jpg")
    maker.block_list.to_remap_image.write("images/tmp/palette.png")

  end

  def test_block_palette
    assert_equal(Digest::MD5.file("images/sample/palette.png"),
      Digest::MD5.file("images/tmp/palette.png"))
  end
end
