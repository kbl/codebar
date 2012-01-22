require 'codebar'

module Codebar
  module Image
    module Processors
      module Convert

        def self.process(path)
          Logger.debug('processing Convert')

          mm_image = MiniMagick::Image.open(path)
          mm_image.format('png')
          mm_image
        end

      end
    end
  end
end
