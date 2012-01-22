require 'spec_helper'

module Codebar
  module Image
    describe Extractor do

      let(:path) { image_path('ean13_clear.png') }
      let(:barcode) { Barcode.new(path) }

      subject { Extractor.new(barcode.processed_image) }

      it 'should return slice of image' do
        subject.extract
      end

    end
  end
end
