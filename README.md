# Tileset/Tilemap creator for GBDK written in GNU Octave/Matlab

I used this code a lot with the old version of GBDK around 2018/2019 to make (unpublished) custom roms. It must be compatible with GBDK2020. This code is better here than rotting on my hard drive. It is completely outdated compared to current Python scripts doing the same, but who knows, maybe it could still present an interest for some folk on internet. It can be used for sprites or background.

## What is the code doing ?
- it takes any image in png, 4 colors, and searches recursively for unique tiles among the whole image.
- it renders the search in a fancy graphical output to guide/help user simplifying the image if two close tiles can be just copied for example.
- it converts the image in tileset and tilemap compatible with GBDK with only unique tiles taken into account.

## What is code NOT doing ?
- the code does not detect tiles identical by flipping/rotation even if this is very easy to include in the current version.
- the code does not care the image size so it's up to you respect the Game Boy screen dimensions to make a level editor with it for example.
- it is intended to be used as a single script but it can be turned easily into a function to automate scripting during code compilation.

## How to use it ?
- install [GNU Octave](https://octave.org/) or use your pricey Matlab licence
- just edit the [image name](https://github.com/Raphael-Boichot/GNU-Octave-tileset-tilemap-creator-for-GBDK/blob/ca894bc3ff5463393935c4b1e606610a5f718c7b/Tile_creator_GBDK.m#L4) to target your image.
- if the image is more than 4 colors, use the [color swapper code](/Color_swapper.m) to fix it and reduce the color number.
- enjoy

## Example of graphical code output
![](/Output.png)
