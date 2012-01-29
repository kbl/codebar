module Codebar

  UnsupportedBarcodeStandardError = Class.new(RuntimeError)

  class Barcode

    SUPPORTED_STANDARDS = {
      ean13: lambda { |bit_array| Codebar::Standard::Ean13::Code.new(bit_array) }
    }

    def initialize(file_path, processor = Image::Processor.new)
      @file_path = file_path
      @processor = processor
    end

    def save_processed(dest_path)
      processed_image.write(dest_path)
    end

    def decode(standard = :ean13)
      barcode_constructor = SUPPORTED_STANDARDS[standard]
      raise UnsupportedBarcodeStandardError unless barcode_constructor

      barcode_bit_array = Image::Extractor.new(processed_image).extract
      barcode = barcode_constructor.call(barcode_bit_array)

      if barcode.valid?
        barcode.decode
      else
        nil
      end
    end

    def processed_image
      @processor.process(@file_path)
    end

  end
end
