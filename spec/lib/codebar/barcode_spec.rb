require 'spec_helper'

module Codebar
  describe Barcode do

    # how I could test automatically image processing? checking chanels, hue, saturation etc?
    it 'is used only for speedup manual testing' do
      path = image_path('ean13_clear.png')
      #path = image_path('ean13_color.png')
      #path = image_path('ean13_blurry.png')
      #path = image_path('isbn13_blurry.png')
      
      b = Barcode.new(path)
      b.save_processed(image_path('result.bmp'))
    end

  end
end
