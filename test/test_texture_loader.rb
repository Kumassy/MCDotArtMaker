require_relative '../lib/mc_dot_art_maker'
require 'test/unit'

class TextureLoaderTest < Test::Unit::TestCase
  TMP_DIR = "images/tmp"
  class << self
    def startup
      # FileUtils.rm_r TMP_DIR
      # Dir.mkdir(TMP_DIR) unless Dir.exist?(TMP_DIR)
    end
  end
  def setup
    @loader = MCDotArtMaker::TextureLoader.new
  end

  def test_version_lists
    assert_equal('/Users/Kyosuke/Library/Application Support/minecraft/versions',@loader.search_dir)

    expected_version = '/Users/Kyosuke/Library/Application Support/minecraft/versions/1.9/1.9.jar'
    assert_equal(expected_version, @loader.jars.sort.last)
    assert_equal(4, @loader.jars.size)
  end

  def test_load_texture
    image = @loader.load_texture('brick.png')
    assert_equal(Magick::Image, image.class)
    assert_equal(16, image.rows)
    assert_equal(16, image.columns)
  end

  def test_load_texture_without_extension
    image = @loader.load_texture('brick')
    assert_equal(Magick::Image, image.class)
    assert_equal(16, image.rows)
    assert_equal(16, image.columns)
  end

  def test_texture_not_found
    assert_raise(MCDotArtMaker::TextureNotFoundError){
      image = @loader.load_texture('abcdefghijklmnopqrstuvwxyz')
    }
  end

  def test_existance
    assert(@loader.exist?('brick.png'))
    assert(@loader.exist?('brick'))

    refute(@loader.exist?('abcdefghijklmnopqrstuvwxyz'))
  end
end
