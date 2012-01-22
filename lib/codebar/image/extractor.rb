require 'codebar'

module Codebar
  module Image
    class Extractor

      WHITE = 0xFFFFFFFF
      BLACK = 0x000000FF

      CONVERSION_MAP = {
        WHITE => ' ',
        BLACK => '#'
      }

      def initialize(image)
        @image = image
      end

      def extract
        width = @image[:width]
        height = @image[:height]
        size = "#{width}x#{height}"

        central_line = height / 2

        @image.combine_options do |i| 
          i.crop "#{size}-0-%s" % central_line
          i.crop "#{size}-0+%s" % (central_line - 1)
        end

        convert_to_pixel_array
      end

      private

      def convert_to_pixel_array
        image = ChunkyPNG::Image.from_blob(@image.to_blob)
        pixels = image.pixels.map { |p| CONVERSION_MAP[p] }

        first = pixels.index(CONVERSION_MAP[BLACK])
        last =  pixels.rindex(CONVERSION_MAP[BLACK])
        length = last - first + 1 # adding one to iclude last index

        pixels.slice(first, length)
      end

    end
  end
end
