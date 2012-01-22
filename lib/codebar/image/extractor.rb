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

        central_line = height / 2

        @image.combine_options do |i| 
          i.crop "#{size}-0-%s" % central_line
          i.crop "#{size}-0+%s" % (central_line - 1)
        end
        @image
      end

    end
  end
end
