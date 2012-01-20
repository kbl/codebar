require 'spec_helper'

module Codebar
  describe Barcode do

    let(:path) {
      image_path('ean13_clear.png')
      # image_path('ean13_color.png')
      # image_path('ean13_blurry.png')
      # image_path('isbn13_blurry.png')
    }

    subject { Barcode.new(path) }

    # how I could test automatically image processing? checking chanels, hue, saturation etc?
    it 'is used only for speedup manual testing' do
      subject.save_processed(image_path('result.bmp'))
    end

  end
end
