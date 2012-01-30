require 'spec_helper'

module Codebar
  describe Barcode do

    let(:path) {
      image_path('ean13_clear3.png')
      # image_path('ean13_color.png')
      # image_path('ean13_blurry.png')
      # image_path('isbn13_blurry.png')
    }

    subject { Barcode.new(path) }

    # how I could test automatically image processing? checking chanels, hue, saturation etc?
    it 'is used only for speedup manual testing' do
      subject.save_processed(image_path('result.png'))
    end

    context 'exceptions' do
      it 'should throw error for unknow barcode standard' do
        lambda do
          subject.decode(:ean134)
        end.should raise_error UnsupportedBarcodeStandardError
      end

      it 'should throw error for unexisting image file' do
        lambda do
          b = Barcode.new(image_path('unexisting_image.test'))
          b.decode
        end.should raise_error Codebar::Image::FileNotFoundError
      end

      it 'should throw error for not text file path passed' do
        lambda do
          b = Barcode.new(image_path(File.join('..', 'spec_helper.rb')))
          b.decode
        end.should raise_error Codebar::Image::InvalidImageFileError
      end

      it 'should throw error for not text file path passed' do
        lambda do
          b = Barcode.new(image_path('ean13_blurry.png'))
          b.decode
        end.should raise_error Codebar::UnknownBarcodeStandardError
      end
    end

    it 'should properly decode barcode, example #2' do
      b = Barcode.new(image_path('ean13_clear2.png'))
      b.decode.should == '0075678164125'
    end

    it 'should properly decode barcode, example #3' do
      b = Barcode.new(image_path('ean13_clear3.png'))
      b.decode.should == '5901234123457'
    end

    it 'should properly decode barcode, example #4' do
      b = Barcode.new(image_path('ean13_clear4.jpg'))
      b.decode(:ean13).should == '5060204120848'
    end

    it 'should properly decode barcode, example #5' do
      b = Barcode.new(image_path('ean13_clear5.png'))
      b.decode.should == '1234567890128'
    end

  end
end
