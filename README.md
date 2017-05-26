# MCDotArtMaker
This gem converts images to dot-art in Minecraft world. You can perform these three kind of conversion.

## source image
![source-image](https://cloud.githubusercontent.com/assets/6278784/26498934/bf10e748-426b-11e7-9877-4d72cd7035d4.jpg)

from: https://www.conoha.jp/conohadocs/blog/10747


## normal output
![normal](https://cloud.githubusercontent.com/assets/6278784/26498939/c31d3c74-426b-11e7-9ace-bda2f7fb7e90.png)

## Minecraft texture version
![texture](https://cloud.githubusercontent.com/assets/6278784/26498947/c94c8b54-426b-11e7-8fbe-f485342cde7d.png)

detail:  
![texture-detail](https://cloud.githubusercontent.com/assets/6278784/26498956/d0e61b50-426b-11e7-9b5b-bd37c4726d0f.png)

## `.schematic`
You can 'paste' the dot-art in Minecraft by using WorldEdit or similar tools.

### 1. Load the .schematic file
![step-1](https://cloud.githubusercontent.com/assets/6278784/26498967/da49e186-426b-11e7-8724-4d12c37f5276.png)

### 2. Perform `//paste` command
![step-2](https://cloud.githubusercontent.com/assets/6278784/26498972/df02d926-426b-11e7-9f30-2c9d03754926.png)

### 3. Result
![step-3](https://cloud.githubusercontent.com/assets/6278784/26498975/e1857c4e-426b-11e7-8b78-a0504db14b91.png)


## Installation
This gem requires ImageMagick. You need to install ImageMagick in advance.

```
$ gem install mc_dot_art_maker
```

## Usage
```
$ mc-dam -i source-image.jpg -t texture -o output
```

-i: input filename  
-t: conversion type (normal | texture | schematic)  
-o: output filename

## Lisence
MIT
