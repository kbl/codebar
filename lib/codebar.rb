require 'mini_magick'
require 'chunky_png'
require 'logger'

require_relative 'codebar/logger'

require_relative 'codebar/image/processors/convert'
require_relative 'codebar/image/processors/grayscale'
require_relative 'codebar/image/processors/sharp'
require_relative 'codebar/image/processors/binary'
require_relative 'codebar/image/extractor'

require_relative 'codebar/standard/ean13/code'

require_relative 'codebar/barcode'
