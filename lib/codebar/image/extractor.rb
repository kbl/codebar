module Codebar
  module Image

    UnableToLacateBarcodeError = Class.new(RuntimeError)

    class Extractor

      WHITE = 0xFFFFFFFF
      BLACK = 0x000000FF

      CONVERSION_MAP = {
        WHITE => '0',
        BLACK => '1'
      }

      def initialize(image)
        @image = image
      end

      def extract
        return @extracted if @extracted

        crop_image_to_central_line
        convert_to_pixel_array
      end

      private

      def crop_image_to_central_line
        width = @image[:width]
        height = @image[:height]
        size = "#{width}x#{height}"

        central_line = height / 2
        @image.combine_options do |i| 
          i.crop "#{size}-0-%s" % central_line
          i.crop "#{size}-0+%s" % (central_line - 1)
        end
      end

      def convert_to_pixel_array
        image = ChunkyPNG::Image.from_blob(@image.to_blob)
        pixels = image.pixels.map { |p| CONVERSION_MAP[p] }

        first = pixels.index(CONVERSION_MAP[BLACK])
        last =  pixels.rindex(CONVERSION_MAP[BLACK])
        
        unless (first and last)
          raise UnableToLacateBarcodeError, "bar code couldn't be detected in central horizontal line of the image"
        end

        length = last - first + 1 # adding one to include last index

        @extracted = pixels.slice(first, length)
      end

    end
  end
end
