require_relative '../lib/mc_dot_art_maker'
require 'test/unit'

class DotTest < Test::Unit::TestCase
  def setup
    @block_list = MCDotArtMaker::BlockList.new
    MCDotArtMaker::Dot.set_color_palette(@block_list)
  end

  def test_determine_block
    dots = []
    dots << MCDotArtMaker::Dot.new(Color::RGB.new(221, 221, 221),0,0)
    dots <<  MCDotArtMaker::Dot.new(Color::RGB.new(231, 228, 219),0,0)
    dots << MCDotArtMaker::Dot.new(Color::RGB.new(231, 228, 219),0,0)
    dots << MCDotArtMaker::Dot.new(Color::RGB.new(114, 119, 106),0,0)
    dots << MCDotArtMaker::Dot.new(Color::RGB.new(249, 236, 78),0,0)

    expected_blocks =[]
    expected_blocks << :white_wool
    expected_blocks << :chiseled_quartz_block
    expected_blocks << :chiseled_quartz_block
    expected_blocks << :mossy_stone_bricks
    expected_blocks << :gold_block
    # blocks = dots.map do |dot|
    #   dot.determine_block
    # end
    blocks = dots.map(&:determine_block)

    blocks.each do |block|
      assert_equal(MCDotArtMaker::Block, block.class)
    end

    blocks.zip(expected_blocks) do |block, expectation|
      assert_equal(expectation, block.name)
    end
  end

  def test_determin_block_for_all_colors
    @block_list.each do |block|
      dot = MCDotArtMaker::Dot.new(block.color,0,0)
      assert_equal(MCDotArtMaker::Block, dot.determine_block.class)
    end
  end
end
