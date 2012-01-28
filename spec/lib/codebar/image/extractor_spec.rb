require 'spec_helper'

module Codebar
  module Image
    describe Extractor do

      let(:path) { 
        # image_path('ean13_clear.png')
        # image_path('ean13_color.png')
        # image_path('ean13_clear.jpg')
        image_path('ean13_clear2.png')
      }
      let(:barcode) { Barcode.new(path) }

      subject { Extractor.new(barcode.processed_image) }

      it 'should return array of transformed pixels' do
        pixels = subject.extract

        pixels.should_not be_empty
        set = Extractor::CONVERSION_MAP.values.inject(Set.new) { |set, pixel| set << pixel }
        set.length.should == 2
      end

    end
  end
end
