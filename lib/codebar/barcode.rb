require 'codebar'

module Codebar
  class Barcode

    PROCESSORS = [
      Codebar::Image::Processors::Convert,
      Codebar::Image::Processors::Grayscale,
      Codebar::Image::Processors::Sharp,
      Codebar::Image::Processors::Binary
    ]
    
    SUPPORTED_STANDARDS = {
      ean13: lambda { |bit_array| Codebar::Standard::Ean13::Code.new(bit_array) }
    }

    def initialize(file_path)
      @file_path = file_path
    end

    def save_processed(dest_path)
      processed_image.write(dest_path)
    end

    def decode
      barcode_bit_array = Image::Extractor.new(processed_image).extract

      SUPPORTED_STANDARDS.each do |name, block|
        barcode = block.call(barcode_bit_array)
        barcode.valid?
      end
    end

    def processed_image
      PROCESSORS.reduce(@file_path) do |image, processor|
        processor.process(image)
      end
    end

  end
end
