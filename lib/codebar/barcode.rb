require 'codebar'

module Codebar
  class Barcode

    PROCESSORS = [
      Codebar::Image::Processors::Convert,
      Codebar::Image::Processors::Grayscale,
      Codebar::Image::Processors::Sharp,
      Codebar::Image::Processors::Binary
    ]

    def initialize(image_file)
      @image_file = image_file
    end

    def save_processed(path)
      PROCESSORS.each { |p| p.process(@image_file) }
    end

    def decode
    end

  end
end
