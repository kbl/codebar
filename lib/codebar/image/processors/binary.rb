require 'codebar'

module Codebar
  module Image
    module Processors
      module Binary

        def self.process(mm_image)
          Logger.debug('processing Binary')

          mm_image.combine_options do |i| 
            i.white_threshold '25%'
            i.colors '2'
            i.normalize
          end

          mm_image
        end

      end
    end
  end
end
