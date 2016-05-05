require_relative '../lib/mc_dot_art_maker'
require 'test/unit'
require "digest/md5"

module MCDotArtMaker
  class Maker
    attr_reader :calculation_count

    public :block_data
    public :block_ids
  end
end
class MakerTest < Test::Unit::TestCase
  def setup
    @maker = MCDotArtMaker::Maker.new("test/images/src/test_image.jpg")
  end

  def test_calculation_count
    assert_equal(0,@maker.calculation_count)
    @maker.calculate

    assert_equal(@maker.width * @maker.height, @maker.calculation_count)
  end

  def test_resize_to_fit
    assert_equal(150, @maker.image.columns)
    assert_equal(100, @maker.image.rows)
    @maker.resize_to_fit(80, 80)
    assert_equal(80, @maker.image.columns)
  end

  def test_modify_after_calculation
    @maker.calculate
    assert_raise(MCDotArtMaker::CannotModifyImageError){
      @maker.resize_to_fit(80, 80)
    }
  end
  def test_manipulate_after_calculation
    @maker.calculate
    assert_raise(MCDotArtMaker::CannotModifyImageError){
      @maker.manipulate do |image|
        image
      end
    }
  end

  def test_get_block_ids_before_calculation
    refute(@maker.block_ids.empty?)
    refute(@maker.block_data.empty?)
  end

  def test_manipulate_image
    @maker.manipulate do |image|
      image.resize_to_fit!(300,300)
      image = image.polaroid do
         self.shadow_color = "gray40"
         self.pointsize = 12
         self.fill="white"
      end
      image
    end
    mosaic = @maker.mosaic_image
    mosaic.write "test/images/tmp/test_manipulate_image.png"
    assert_equal(Magick::Image, mosaic.class)
  end
  def test_manipulate_image_with_invalid_value
    assert_raise(ArgumentError){
      @maker.manipulate do |image|
        :invalid
      end
    }
  end

end
