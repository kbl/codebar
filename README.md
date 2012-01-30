# Codebar

Library with siple api for bar code recognition

## Supported file formats

All files supported by `ImageMagick` are supported. `Codebar` internals process image to get best possible view of barcode, and convert its to plain bitmap on which all reading operations are performed.

## Supported barcode types

* EAN13
* UPC-A

## Usage

    require 'codebar'

    barcode = Codebar::Barcode.new('/path/to/image_file.gif')
    barcode.decode(:ean13)

You could also try to decode `Barcode` without specyfing bar code encoding standard. In such case library will choose appropriate standard (if such is implemented and image could be processed).

    require 'codebar'

    barcode = Codebar::Barcode.new('/path/to/image_file.gif')
    barcode.decode

# Requirements

`Codebar` depends on two external gems:

 * `mini_magick` - image processing tasks,
 * `chunky_png` - cutting acutal pixels from image file.

Former indicates rather heavy dependency on ImageMagick.

## Issues

`Codebar` was tested on

    Linux ubuntu 2.6.38-13-generic
    ruby 1.9.2p290 (2011-07-09 revision 32553) [x86_64-linux]
    ImageMagick 6.6.7-5 2011-02-06 Q16

And all specs are green, but it's proven to fail on certain setups (issue #6).

## Things to be done

 * Rotation detection (bar code upside down),
 * Distance algorithms for not exact matching numbers,
 * Support of different bar code encoding standards,
 * Support of different platforms.

## Sample images

Following list contains sample images used during tests and development

 * ean13\_clear3.png - http://en.wikipedia.org/wiki/International\_Article\_Number\_(EAN)
 * ean13\_blurry.png - http://people.inf.ethz.ch/adelmanr/batoo/
 * isbn13\_blurry.png - _Robust 1D Barcode Recognition on Mobile Devices_ by Johann C. Rocholl, Sebastian Klenk, Gunther Heidemann
 * ean13\_color.png - _Research and Application of the EAN-13 Barcode Recognition on Iphone_ by YeMin Li, Li Zeng
 * ean13\_clear5.png - http://jjil.googlecode.com/

## Licence

Copyright (c) 2012 Marcin Pietraszek

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicence, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
