require 'codebar'

module Codebar
  module Image
    module Processors
      module Binary

        def self.process(mm_image)
          return mm_image

          mm_image.combine_options do |i| 
            i.colors '2'
            i.normalize
          end
          
          #mm_image.combine_options do |i|
          #  i.threshold '2'
          #end

          mm_image
        end

      end
    end
  end
end
