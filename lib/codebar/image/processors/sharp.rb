require 'codebar'

module Codebar
  module Image
    module Processors
      module Sharp

        def self.process(mm_image)
          radius = 1.4
          sigma = radius
          amount = 5
          threshold = 0

          mm_image.combine_options do |i| 
            i.unsharp "#{radius}x#{sigma}+#{amount}+#{threshold}"
          end

          mm_image
        end

      end
    end
  end
end
