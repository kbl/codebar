require 'spec_helper'

module Codebar
  describe Barcode do

    # how I could test automatically image processing? checking chanels, hue, saturation etc?
    it 'is used only for speedup manual testing' do
      image('ean13_color.png') do |f|
        b = Barcode.new(f)

        b.save_processed(File.join(image_folder, 'result.bmp'))
      end
    end

  end
end
