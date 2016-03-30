# MCDotArtMaker
This gem will help you to create dot-art in Minecraft world.

# Function
- Converting images(.png .jpg ...) to dot-art using Minecraft texture.
- Also you can maker .schematic files so that you can paste dot-art to Minecraft world easily.

# Install
This gem uses RMagick which requires ImageMagick. So first of all,you need to install ImageMagick.  
Then run `gem install mc_dot_art_maker`
# Usage
See examples.  

First, load image files.
`maker = MCDotArtMaker::Maker.new("test_image.jpg")`  
You can resize images like this: `maker.resize_to_fit(50,50)`  
This means width/height of output image will be less than 50 blocks.

Run this command to write dot-art: `maker.texture_image.write "test_image_texture.png"`  
Also you can write dot-art without using Minecraft textures: `maker.mosaic_image.write "test_image_mosaic.png"`
