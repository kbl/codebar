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

      # Converts all images to png fomat used in furhter processing.
      #
      # +chunky_png+ gem is used to read image data.
      def convert(path)
        mm_image = MiniMagick::Image.open(path)
        mm_image.format('png')
        mm_image
      end

      # Converting image to grayscale.
      def gray_is_great(mm_image)
        mm_image.combine_options { |i| i.colorspace 'Gray' }
        mm_image
      end
      
      # Attempt to sharpen image.
      #
      # Parameters for image sharpening was choosed as suggested in article
      # http://redskiesatnight.com/2005/04/06/sharpening-using-image-magick/
      def sharpen(mm_image)
        radius = 1.4
        sigma = radius
        amount = 4
        threshold = 0

        mm_image.combine_options do |i| 
          i.unsharp "#{radius}x#{sigma}+#{amount}+#{threshold}"
        end

        mm_image
      end

      # Convertin image to black/white without other grayscale colors.
      def binarize(mm_image)
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
