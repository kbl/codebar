require 'codebar'

module Codebar
  module Image
    class Extractor

      def initialize(image)
        @image = image
      end

      def extract
        width = @image[:width]
        height = @image[:height]
        size = "#{width}x#{height}"

        central_line = width / 2
        central_line -= 1

        @image.combine_options do |i| 
          i.crop "#{size}-0-%s" % 79
          i.crop "#{size}-0+%s" % 80
        end
        @image
      end

    end
  end
end
