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
