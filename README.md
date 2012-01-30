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

## Sample images

Following list contains sample images used during tests and development

 * ean13\_clear3.png - http://en.wikipedia.org/wiki/International\_Article\_Number\_(EAN)
 * ean13\_blurry.png - http://people.inf.ethz.ch/adelmanr/batoo/
 * isbn13\_blurry.png - _Robust 1D Barcode Recognition on Mobile Devices_ by Johann C. Rocholl, Sebastian Klenk, Gunther Heidemann
 * ean13\_color.png - _Research and Application of the EAN-13 Barcode Recognition on Iphone_ by YeMin Li, Li Zeng
 * ean13\_clear.jpg - http://www.terrapin.co.uk/services/bcspecean13.html
 * ean13\_clear2.jpg - http://www.terrapin.co.uk/services/bcspecean13.html
 * ean13\_clear5.png - http://jjil.googlecode.com/

## Progress

 * Reading image from file with preprocessing (converting into grayscale, sharpeing, binarization),
 * Decoding EAN13 barcodes from perfectly clear images.

## TODO (;

 * Rotation detection (bar code upside down),
 * Distance algorithms for not exact matching numbers,
 * Support of different bar code encoding standards.
