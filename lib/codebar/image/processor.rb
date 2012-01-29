module Codebar
  module Image
    class Processor

      APPLIED_PROCESSINGS = %w(convert gray_is_great sharpen binarize)

      def process(file_path)
        APPLIED_PROCESSINGS.reduce(file_path) do |image, processing|
          send(processing, image)
        end
      end

      private

      def binarize(mm_image)
        Logger.debug('processing Binary')

        mm_image.combine_options do |i| 
          i.white_threshold '25%'
          i.colors '2'
          i.normalize
        end

        mm_image
      end

      def convert(path)
        Logger.debug('processing Convert')

        mm_image = MiniMagick::Image.open(path)
        mm_image.format('png')
        mm_image
      end

      def gray_is_great(mm_image)
        Logger.debug('processing Grayscale')

        mm_image.combine_options { |i| i.colorspace 'Gray' }
        mm_image
      end
      
      def sharpen(mm_image)
        Logger.debug('processing Sharp')

        radius = 1.4
        sigma = radius
        amount = 4
        threshold = 0

        mm_image.combine_options do |i| 
          i.unsharp "#{radius}x#{sigma}+#{amount}+#{threshold}"
        end

        mm_image
      end

    end
  end
end
