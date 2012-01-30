module Codebar

  UnsupportedBarcodeStandardError = Class.new(RuntimeError)
  UnknownBarcodeStandardError = Class.new(RuntimeError)

  class Barcode

    SUPPORTED_STANDARDS = {
      'ean13' =>  lambda { |bit_array| Codebar::Standard::Ean13::Code.new(bit_array) },
      'upc-a' =>  lambda { |bit_array| Codebar::Standard::Ean13::Code.new(bit_array) }
    }

    def initialize(file_path, processor = Image::Processor.new)
      @file_path = file_path
      @processor = processor
    end

    def save_processed(dest_path)
      processed_image.write(dest_path)
    end

    def decode(standard = nil)
      @barcode_bit_array = Image::Extractor.new(processed_image).extract

      if standard
        barcode_constructor = SUPPORTED_STANDARDS[standard.to_s]
        raise UnsupportedBarcodeStandardError, "provided standard #{standard} isn't supported" unless barcode_constructor

        decode_image(barcode_constructor)
      else
        detect_standard_and_decode_image
      end
    end

    def processed_image
      @processor.process(@file_path)
    end

    private

    def decode_image(barcode_constructor)
      barcode = barcode_constructor.call(@barcode_bit_array)

      if barcode.valid?
        barcode.decode
      else
        nil
      end
    end

    def detect_standard_and_decode_image
      SUPPORTED_STANDARDS.values.each do |barcode_constructor|
        begin
          decoded = decode_image(barcode_constructor)
          return decoded if decoded
        rescue Codebar::Standard::BarcodeDataCorruptedError
          # maybe next standard will decode image successfully?
        end
      end

      raise UnknownBarcodeStandardError, 'barcode standard detection failed'
    end

  end
end
