require 'codebar'

module Codebar
  module Image
    module Processors
      module Sharp

        def self.process(mm_image)
          mm_image.combine_options do |i| 
            i.unsharp '3.0x1.0+4.0+2.10'
            #i.unsharp '1.2x1.2+5+0'
            #i.unsharp '0x1.2+5+0'
          end
          mm_image
        end

      end
    end
  end
end
