require 'codebar'

module Codebar
  module Image
    module Processors
      module Grayscale

        def self.process(mm_image)
          mm_image.combine_options { |i| i.colorspace 'Gray' }
          mm_image
        end

      end
    end
  end
end
