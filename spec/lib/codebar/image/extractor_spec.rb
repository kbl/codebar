require 'spec_helper'

module Codebar
  module Image
    describe Extractor do

      let(:path) { image_path('ean13_clear.png') }
      let(:barcode) { Barcode.new(path) }

      subject { Extractor.new(barcode.processed_image) }

      it 'should return slice of image' do
        image = subject.extract
        image.write(image_path('dupa.bmp'))
      end

    end
  end
end
