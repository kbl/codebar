require 'codebar'

module Codebar

  UnsupportedBarcodeStandardError = Class.new(RuntimeError)

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

    def decode(standard = :ean13)
      barcode_constructor = SUPPORTED_STANDARDS[standard]
      raise UnsupportedBarcodeStandardError unless barcode_constructor

      barcode_bit_array = Image::Extractor.new(processed_image).extract
      barcode = barcode_constructor.call(barcode_bit_array)
      barcode.valid?
    end

    def processed_image
      PROCESSORS.reduce(@file_path) do |image, processor|
        processor.process(image)
      end
    end

  end
end
