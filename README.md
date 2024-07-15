# Tileset/Tilemap creator for GBDK written in GNU Octave/Matlab

I used this code a lot with the first version of GBDK, around 2018/2019, to make (unpublished) custom roms. This code is better here than rotting on my hard drive. It is probably outdated compared to current Python scripts doing the same for GBDK2020, but who knows, maybe it could still present an interest for some folk on internet. It can be used for sprites or background conversion. I've created this code out of curiosity to understand the [tile encoding format](https://www.huderlem.com/demos/gameboy2bpp.html) on Game Boy. Functions are very similar to [Pic2tiles](http://www.budmelvin.com/dev/index.html) made by Bud Melvin which serves as inspiration.

## What is the code doing ?
- it takes any image in any lossless format (BMP, PNG, GIF, etc.), 4 colors, multiple of 8x8 pixels, and searches recursively for unique tiles among the whole image.
- it renders the search in a fancy graphical output to guide/help user simplifying the image if two very similar tiles can just be merdeg for example.
- it converts the image in tileset and tilemap compatible with GBDK with only unique tiles taken into account.

## What is the code NOT doing ?
- the code does not detect tiles identical by flipping/rotation even if this is very easy to include in the current version.
- the code does not care the whole image size so it's up to you respect the Game Boy screen dimensions to make a level editor with it for example.
- it is intended to be used as a single script but it can be turned easily into a function to automate scripting during code compilation.
- it does not create ASM and binary output but it may be very easy to code these features from this base.
- it does not stop if the number of tiles is up to 255 for tilemap, it's up to you to check that.

## How to use it ?
- install [GNU Octave](https://octave.org/) or use your pricey Matlab licence.
- just edit the [image name](https://github.com/Raphael-Boichot/GNU-Octave-tileset-tilemap-creator-for-GBDK/blob/ca894bc3ff5463393935c4b1e606610a5f718c7b/Tile_creator_GBDK.m#L4) to target your image.
- if the image is more than 4 colors, use the [color swapper code](/Color_swapper.m) to fix it and reduce the color number one by one.
- enjoy this simple tool.

## Example of graphical code output with the provided test image
![](/Output.png)

Unique tiles are marked with a green square, redunding tiles are marqued with a red cross. The "VRAM" figure displays the unique tiles and their probable arrangement in Game Boy VRAM when the test image is displayed as background.

## Another Example of graphical code output
![](/Output_2.png)

## Example of text code output with the provided test image

The 160x144 test image, supposed to fill a complete Game Boy Screen (90 unique tiles).

![](/Test_image.png)

The tilemap is presented with one width of screen (20 tiles or 160*8 pixels) per line of data but GBDK does not care, it's just for ease of reading.
```c
unsigned char tilemap[] =
{
0x00,0x01,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x01,0x00,
0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,
0x02,0x02,0x02,0x02,0x02,0x03,0x04,0x05,0x05,0x05,0x05,0x05,0x05,0x06,0x07,0x02,0x02,0x02,0x02,0x02,
0x02,0x02,0x02,0x02,0x02,0x08,0x09,0x0A,0x0B,0x0C,0x0C,0x0D,0x0A,0x0E,0x0F,0x02,0x02,0x02,0x02,0x02,
0x02,0x02,0x02,0x02,0x02,0x10,0x11,0x12,0x13,0x13,0x13,0x13,0x14,0x15,0x16,0x02,0x02,0x02,0x02,0x02,
0x02,0x02,0x02,0x02,0x02,0x10,0x17,0x18,0x01,0x01,0x01,0x01,0x19,0x1A,0x16,0x02,0x02,0x02,0x02,0x02,
0x02,0x02,0x02,0x02,0x02,0x10,0x1B,0x1C,0x01,0x01,0x01,0x01,0x19,0x1A,0x16,0x02,0x02,0x02,0x02,0x02,
0x02,0x02,0x02,0x02,0x02,0x10,0x1D,0x1E,0x1F,0x1F,0x1F,0x1F,0x20,0x1A,0x16,0x02,0x02,0x02,0x02,0x02,
0x02,0x02,0x02,0x02,0x02,0x21,0x22,0x23,0x24,0x24,0x24,0x24,0x25,0x26,0x27,0x02,0x02,0x02,0x02,0x02,
0x02,0x02,0x02,0x02,0x02,0x28,0x29,0x29,0x29,0x29,0x29,0x29,0x29,0x2A,0x2B,0x02,0x02,0x02,0x02,0x02,
0x02,0x02,0x02,0x02,0x02,0x2C,0x2D,0x2E,0x2F,0x2F,0x2F,0x2F,0x30,0x31,0x2B,0x02,0x02,0x02,0x02,0x02,
0x02,0x02,0x02,0x02,0x02,0x32,0x33,0x34,0x35,0x2F,0x36,0x37,0x38,0x39,0x2B,0x02,0x02,0x02,0x02,0x02,
0x02,0x02,0x02,0x02,0x02,0x3A,0x3B,0x3C,0x3D,0x2F,0x3E,0x3F,0x40,0x41,0x2B,0x02,0x02,0x02,0x02,0x02,
0x02,0x02,0x02,0x02,0x02,0x2C,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x02,0x02,0x02,0x02,0x02,
0x02,0x02,0x02,0x02,0x02,0x2C,0x2F,0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,0x52,0x02,0x02,0x02,0x02,0x02,
0x02,0x02,0x02,0x02,0x02,0x53,0x54,0x55,0x55,0x55,0x55,0x56,0x57,0x58,0x59,0x02,0x02,0x02,0x02,0x02,
0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,
0x00,0x01,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x02,0x01,0x00
};
```

The tileset is presented with one tile (16 bytes) per line but GBDK does not care, it's just for ease of reading too.
```c
unsigned char tileset[] =
{
0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,
0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,
0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
0x00,0x1F,0x3E,0x3F,0x0B,0x74,0xDC,0xE0,0x7D,0xC0,0xDE,0xE0,0x54,0xFF,0xEA,0xFF,
0x00,0x3F,0x3F,0x3F,0x3F,0xC0,0x8A,0xC0,0x91,0xC0,0xAA,0xC0,0xC4,0xFF,0xAA,0xFF,
0x00,0xFF,0xFF,0xFF,0xFF,0x00,0xAA,0x00,0x51,0x00,0xAA,0x00,0x04,0xFF,0xAA,0xFF,
0x00,0xFC,0xFC,0xFE,0xFC,0x03,0xA9,0x03,0x51,0x03,0xA8,0x03,0x03,0xFF,0xAA,0xFF,
0x00,0xF0,0xF0,0xF8,0xF0,0x0C,0xAC,0x0C,0x84,0x0C,0xA4,0x0C,0x0C,0xFC,0xAC,0xFC,
0x7D,0xC0,0xDE,0xE0,0x7F,0xC0,0x95,0xEA,0xFF,0xC3,0xDE,0xE3,0x7B,0xC7,0x97,0xEB,
0x55,0x00,0xAA,0x00,0x77,0xFF,0xAA,0xFF,0x3F,0xC0,0x15,0xEA,0x3F,0xFF,0x2A,0xFF,
0x55,0x00,0xAA,0x00,0x77,0xFF,0xAA,0xFF,0xFF,0x00,0x55,0xAA,0xFF,0xFF,0xAA,0xFF,
0x55,0x00,0xAA,0x00,0x77,0xFF,0xAA,0xFF,0xFF,0x00,0x55,0xAA,0xEB,0xF4,0xB5,0xEA,
0x55,0x00,0xAA,0x00,0x77,0xFF,0xAA,0xFF,0xFF,0x00,0x55,0xAA,0xBB,0x44,0x55,0xAA,
0x55,0x00,0xAA,0x00,0x77,0xFF,0xAA,0xFF,0xFF,0x00,0x55,0xAA,0xFF,0x7F,0x2A,0xFF,
0x55,0x00,0xAA,0x00,0x77,0xFF,0xAB,0xFF,0xFD,0x03,0x57,0xAB,0xF5,0xFB,0xA7,0xFB,
0x54,0x0C,0xA4,0x0C,0xC4,0x0C,0xAC,0x0C,0x84,0x0C,0xA4,0x0C,0x84,0x0C,0xAC,0x0C,
0x7F,0xC3,0xDE,0xE3,0x7B,0xC7,0x9F,0xE3,0xFF,0xC3,0xDE,0xE3,0x7B,0xC7,0x97,0xEB,
0x3F,0xC0,0x15,0xEA,0x3B,0xC4,0x15,0xEA,0x2E,0xD1,0x15,0xEA,0x3B,0xC4,0x15,0xEA,
0xFF,0x00,0x51,0xAE,0xBF,0x7F,0x20,0xFF,0xAF,0x70,0x2F,0xF0,0xAF,0x70,0x67,0xB8,
0xFF,0x00,0x11,0xEE,0xFF,0xFF,0x00,0xFF,0xFF,0x00,0xFD,0x02,0xFF,0x00,0xFF,0x00,
0xFF,0x00,0x11,0xEE,0xFD,0xFE,0x0D,0xFE,0xF5,0x0E,0xD5,0x2E,0xF5,0x0E,0xF5,0x0E,
0xFD,0x03,0x57,0xAB,0xBD,0x43,0x57,0xAB,0xAD,0x53,0x57,0xAB,0xBD,0x43,0x57,0xAB,
0x84,0x0C,0xA4,0x0C,0x84,0x0C,0xAC,0x0C,0x84,0x0C,0xA4,0x0C,0x84,0x0C,0xAC,0x0C,
0x2E,0xD1,0x15,0xEA,0x3B,0xC4,0x15,0xEA,0x3E,0xC1,0x19,0xEE,0x2B,0xDC,0x22,0xFF,
0xAF,0x70,0x2F,0xF0,0xAF,0x70,0x2F,0xF0,0xAF,0x70,0x2F,0xF0,0xAF,0x70,0x27,0xF8,
0xF5,0x0E,0xD5,0x2E,0xF5,0x0E,0xF5,0x0E,0xF5,0x0E,0xF5,0x0E,0xF5,0x0E,0xF5,0x0E,
0xED,0x13,0x57,0xAB,0xBD,0x43,0x57,0xAB,0xAD,0x53,0x57,0xAB,0xBD,0x43,0x57,0xAB,
0x2A,0xF7,0x19,0xEE,0x23,0xDC,0x15,0xEA,0x2E,0xD1,0x15,0xEA,0x3B,0xC4,0x15,0xEA,
0xAF,0x70,0x2F,0xF0,0xAF,0x70,0x2F,0xF0,0xAF,0x70,0x2F,0xF0,0xAF,0x70,0x67,0xB8,
0x2E,0xD1,0x15,0xEA,0x3B,0xC4,0x15,0xEA,0x2E,0xD1,0x15,0xEA,0x3B,0xC4,0x15,0xEA,
0xAF,0x70,0x2F,0xF0,0xAF,0x70,0x2D,0xF2,0xAF,0x70,0x2D,0xF2,0xB0,0x7F,0x3F,0xFF,
0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xFF,0x00,0xDD,0x22,0x00,0xFF,0xFF,0xFF,
0xF5,0x0E,0xD5,0x2E,0xF5,0x0E,0xF5,0x0E,0xF5,0x0E,0xD5,0x2E,0x05,0xFE,0xFD,0xFE,
0x7F,0xC3,0xDE,0xE3,0x7B,0xC7,0x9F,0xE3,0xFF,0xC3,0xDE,0xE3,0x7B,0xC7,0x96,0xEB,
0x2E,0xD1,0x15,0xEA,0x3B,0xC4,0x15,0xEA,0x0E,0xF1,0x25,0xFA,0x00,0xFF,0x00,0xFF,
0x80,0x7F,0x55,0xAA,0xBB,0x44,0x55,0xAA,0xAE,0x51,0x55,0xAA,0x00,0xFF,0x00,0xFF,
0x00,0xFF,0x55,0xAA,0xBB,0x44,0x55,0xAA,0xAE,0x51,0x55,0xAA,0x00,0xFF,0x00,0xFF,
0x03,0xFC,0x55,0xAA,0xBB,0x44,0x55,0xAA,0xAE,0x51,0x55,0xAA,0x00,0xFF,0x00,0xFF,
0xED,0x13,0x57,0xAB,0xB3,0x4C,0x5E,0xAC,0xB6,0x4C,0x56,0xAC,0x7C,0xF0,0xFA,0xF0,
0x84,0x0C,0xA4,0x0C,0x44,0x0C,0xAC,0x0C,0x04,0x0C,0xA4,0x0C,0x44,0x0C,0xAC,0x0C,
0x7E,0xC1,0xDF,0xE0,0x7D,0xC0,0x96,0xE8,0xFD,0xC0,0xDE,0xE0,0x7C,0xC0,0x96,0xE8,
0xFF,0xFF,0xEE,0xFF,0xFF,0x00,0xFF,0x00,0x01,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,
0x79,0x80,0x5A,0xA0,0xC4,0x00,0xAA,0x00,0x01,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,
0x04,0x0C,0xA4,0x0C,0x44,0x0C,0xAC,0x0C,0x04,0x0C,0xA4,0x0C,0x44,0x0C,0xAC,0x0C,
0x7D,0xC0,0xDE,0xE0,0x7C,0xC0,0x96,0xE8,0xFD,0xC0,0xDE,0xE0,0x7C,0xC0,0x96,0xE8,
0x11,0x00,0xAA,0x00,0x40,0x00,0xAD,0x02,0x1B,0x07,0xB0,0x0F,0x6F,0x1C,0xF9,0x0E,
0x11,0x00,0xAA,0x00,0x04,0x00,0x5A,0xA0,0xE1,0xF0,0x16,0xE8,0xE8,0x1C,0x8C,0xF8,
0x11,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,0x01,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,
0x11,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,0x01,0x00,0xAA,0x00,0x44,0x00,0xAA,0x01,
0x11,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,0x01,0x00,0xAA,0x00,0x04,0x00,0x0A,0xF0,
0x7D,0xC0,0xDF,0xE0,0x7F,0xC0,0x96,0xEB,0xFF,0xC3,0xDE,0xE3,0x7B,0xC7,0x97,0xEB,
0xFA,0x0D,0xA9,0xFE,0xFA,0xFD,0x95,0xEA,0x3E,0xC1,0x29,0xFE,0x3E,0xFD,0x09,0xFE,
0xA8,0xDC,0x88,0xFF,0xAF,0xDF,0x55,0xAA,0xFF,0x00,0x1A,0xEF,0x2E,0xDF,0x55,0xAA,
0x11,0x00,0x6A,0x80,0x84,0xC0,0x5A,0xA0,0xB1,0x60,0xB2,0x60,0xB4,0x60,0x3A,0xE0,
0x11,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,0x01,0x00,0xAA,0x00,0x44,0x00,0xAC,0x03,
0x11,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,0x01,0x00,0xA0,0x7E,0xFC,0x7E,0x5E,0xA1,
0x03,0x01,0xA0,0x0F,0x75,0x0E,0xB6,0x0F,0x35,0x0F,0xB6,0x0F,0x34,0x0F,0x2D,0x83,
0xF9,0xF0,0x52,0xAC,0xF6,0x0C,0x66,0x8C,0x36,0xCC,0x16,0xEC,0x56,0xEC,0xA2,0xF8,
0x7F,0xC3,0xDD,0xE2,0x7F,0xC0,0x95,0xEA,0xFF,0xC0,0xDE,0xE0,0x7C,0xC0,0x96,0xE8,
0x02,0xFD,0xE8,0xFF,0x7C,0xFF,0x78,0x8F,0xEC,0x1F,0x99,0x2E,0x74,0x0F,0x9F,0x23,
0xAA,0x55,0x8A,0xFF,0xAD,0xDF,0xAC,0xD8,0xA9,0xDC,0xCA,0x3C,0x80,0x7C,0xF2,0xE0,
0x95,0x60,0xEA,0x80,0x44,0x80,0xAA,0x00,0x01,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,
0x07,0x01,0xAC,0x03,0x47,0x01,0xAD,0x03,0x07,0x01,0xAB,0x00,0x45,0x00,0xAA,0x00,
0xBF,0xC1,0x93,0xE9,0x8F,0xF1,0x85,0xFB,0x11,0xFF,0x7C,0xFE,0xF4,0x7E,0xFE,0x00,
0x0D,0x83,0x2B,0x80,0x03,0x80,0x2A,0x80,0x81,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,
0xF9,0xF0,0x5A,0xA0,0xF0,0x00,0xAA,0x00,0x01,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,
0x78,0x07,0xA7,0x08,0x5F,0x00,0xAA,0x00,0x01,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,
0x05,0xF0,0xCA,0x20,0xF4,0x00,0xAA,0x00,0x51,0x00,0xAA,0x00,0x44,0x03,0xA7,0x03,
0x11,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,0x7D,0x00,0x7E,0x38,0x83,0x7C,0xBB,0xC6,
0x11,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,0x11,0x00,0xA2,0x01,0x5A,0x05,0x8F,0x1E,
0x10,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,0xF1,0x00,0xE2,0xE0,0x0C,0xF0,0xDA,0x38,
0x7E,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,0x01,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,
0x11,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,0x01,0x00,0xAA,0x00,0x42,0x01,0xA9,0x03,
0x11,0x00,0xAA,0x00,0x74,0x00,0x9A,0x30,0x2E,0x10,0xB6,0x0C,0xBA,0x05,0x2F,0x83,
0x04,0x0C,0xA4,0x0C,0x44,0x0C,0xAC,0x0C,0x04,0x0C,0xA4,0x0C,0xC4,0x0C,0xAC,0x0C,
0x10,0x0F,0xB8,0x0F,0x5B,0x07,0xAB,0x07,0x16,0x01,0xA1,0x02,0x47,0x00,0xAA,0x00,
0x01,0xFE,0x3C,0xFA,0xAF,0xD0,0xB2,0xC8,0xD1,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,
0x40,0x3F,0x21,0x7F,0x74,0x1F,0xEF,0x1E,0x5B,0x04,0xBC,0x02,0x54,0x00,0xAA,0x00,
0x0D,0xF0,0xFA,0xE0,0xB4,0x40,0x6A,0x80,0x51,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,
0x11,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,0x01,0x00,0xAA,0x00,0x46,0x01,0xAD,0x03,
0x12,0x01,0xAB,0x00,0x2B,0x10,0xB2,0x18,0x32,0x0C,0xB4,0x0E,0x88,0x07,0x2D,0x83,
0x2E,0xC1,0x4B,0xE0,0x8B,0x70,0xFA,0x30,0x62,0x1C,0xB6,0x0C,0x9A,0x04,0x2E,0x80,
0x04,0xCC,0xE4,0xCC,0xA4,0x4C,0xEC,0x0C,0x44,0x0C,0xA4,0x0C,0x48,0x30,0x90,0x30,
0x7F,0xC0,0xDD,0xE2,0x7F,0xC0,0x15,0x6A,0x3F,0x30,0x05,0x1A,0x0F,0x0F,0x02,0x07,
0x11,0x00,0xAA,0x00,0xC4,0x00,0x6A,0x80,0xFF,0x00,0x55,0xAA,0xFF,0xFF,0xAA,0xFF,
0x11,0x00,0xAA,0x00,0x44,0x00,0xAA,0x00,0xFF,0x00,0x55,0xAA,0xFF,0xFF,0xAA,0xFF,
0x16,0x01,0xAB,0x00,0x44,0x00,0xAA,0x00,0xFF,0x00,0x55,0xAA,0xFF,0xFF,0xAA,0xFF,
0x63,0xC0,0x4B,0xE0,0xD8,0x30,0xC2,0x38,0xF5,0x0E,0x57,0xAE,0xFF,0xFF,0xAA,0xFF,
0x65,0xC0,0x4A,0xE0,0xA0,0x40,0xEA,0x00,0xF7,0x0F,0x52,0xAF,0xF0,0xF8,0xA0,0xF0,
0x10,0x30,0x80,0x20,0x40,0xC0,0x00,0xC0,0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00
};
```

Well, it does what it's supposed to do. 
