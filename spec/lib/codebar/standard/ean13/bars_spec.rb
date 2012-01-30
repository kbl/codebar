require 'spec_helper'

module Codebar
  module Standard
    module Ean13
      describe Bars do

        let (:ean13_clear2) { '1100110000001111001100111111001111001111000000110011001111111100111111001111001111001111110011001100111100001111001100110000000011001111110000111100001111001111001111000011000011111100110011'
                                .split('') }
        let (:ean13_clear2_normalized) { '10100011010111011011000101011110111011011011101010110011010100001011100110011011011001001110101' }

        context '#narrow_width' do
          it 'should find bar width, example #2' do
            Bars.new(ean13_clear2).narrow_width.should == 2
          end
        end

        context '#normalized' do
          it 'should properly normalize code' do
            Bars.new(ean13_clear2).normalized.join('').should == ean13_clear2_normalized
          end
        end

      end
    end
  end
end
