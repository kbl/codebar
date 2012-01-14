require 'codebar'

module Codebar
  class Barcode

    PROCESSORS = [
      Codebar::Image::Processors::Convert,
      Codebar::Image::Processors::Grayscale,
      Codebar::Image::Processors::Sharp,
      Codebar::Image::Processors::Binary
    ]

    def initialize(file_path)
      @file_path = file_path
    end

    def save_processed(dest_path)
      result = PROCESSORS.reduce(@file_path) do |image, processor|
        p image
        processor.process(image)
      end
      
      result.write(dest_path)
    end

    def decode
    end

  end
end
