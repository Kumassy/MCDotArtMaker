Gem::Specification.new do |s|
	s.name = 'mc_dot_art_maker'
	s.version = '0.4.0'
	s.licenses = ['MIT']
	s.summary = 'Dot Art Maker for Minecraft'
	s.description = 'Converting images to mosaic arts using Minecraft textures and .schematic files.'
	s.authors = ['Kumassy']
	s.files = `git ls-files -z`.split("\x0")
	s.homepage = 'https://github.com/Kumassy/MCDotArtMaker'

	s.add_development_dependency 'bindata'
	s.add_development_dependency 'color-rgb'
	s.add_development_dependency 'nbt_utils'
	s.add_development_dependency 'rmagick'
	s.add_development_dependency "bundler", "~> 1.11"
	s.add_development_dependency "rake", "~> 10.0"
	s.add_development_dependency "rspec", "~> 3.0"
end
