require 'codebar'

module Codebar
  module Image
    module Processors
      module Binary

        def self.process(mm_image)
          mm_image << '+dither'
          mm_image.combine_options do |i| 
            i.colors '2'
            i.normalize
          end

          mm_image
        end

      end
    end
  end
end
