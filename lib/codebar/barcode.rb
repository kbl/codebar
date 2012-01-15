require 'codebar'

module Codebar
  class Barcode

    PROCESSORS = [
      Codebar::Image::Processors::Convert,
      Codebar::Image::Processors::Grayscale,
      Codebar::Image::Processors::Sharp,
      Codebar::Image::Processors::Binary
    ]
    
    SUPPORTED_STANDARDS = [
      Codebar::Standard::Ean13::Code
    ]

    def initialize(file_path)
      @file_path = file_path
    end

    def save_processed(dest_path)
      result = process
      result.write(dest_path)
    end

    def decode
      processed_image = process
      barcode_bit_array = Image::Extractor.new(processed_image).extract

      SUPPORTED_STANDARDS.each do |t|
        barcode = t.new(barcode_bit_array)
        barcode.valid?
      end
    end

    private

    def process
      PROCESSORS.reduce(@file_path) do |image, processor|
        processor.process(image)
      end
    end

  end
end
