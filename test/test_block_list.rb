require_relative '../lib/mc_dot_art_maker'
require 'test/unit'

class BlockListTest < Test::Unit::TestCase
  def setup
    @block_list = MCDotArtMaker::BlockList.new
  end

  # def test_singleton
  #   assert_raise(NoMethodError){
  #     MCDotArtMaker::BlockList.new
  #   }
  #   assert_equal(MCDotArtMaker::BlockList,@block_list.class)
  # end

  def test_block_list
    assert_equal(58, @block_list.size)
    assert_equal(58, @block_list.length)

    @block_list.each do |block|
      assert_equal(MCDotArtMaker::Block, block.class)
      assert_equal(Magick::Image, block.texture.class)
      assert_equal(16, block.texture.rows)
      assert_equal(16, block.texture.columns)
    end
  end

  def test_color_palette
    @block_list.color_palette.write("test/images/tmp/palette.png")

    assert_equal(Magick::Image, @block_list.color_palette.class)
    assert_equal(Digest::MD5.file("test/images/sample/palette.png"),
      Digest::MD5.file("test/images/tmp/palette.png"))
  end
end
