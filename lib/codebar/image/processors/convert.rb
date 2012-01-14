require 'codebar'

module Codebar
  module Image
    module Processors
      module Convert

        def self.process(path)
          i = MiniMagick::Image.open(path)
          i.format('bmp')
          i
        end

      end
    end
  end
end
