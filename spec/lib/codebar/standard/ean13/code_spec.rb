require 'spec_helper'

module Codebar
  module Standard
    module Ean13
      describe Code do

        let (:ean13_clear2) { '1100110000001111001100111111001111001111000000110011001111111100111111001111001111001111110011001100111100001111001100110000000011001111110000111100001111001111001111000011000011111100110011'
                                .split('') }

        it 'should properly decode bar code, example #2' do
          Code.new(ean13_clear2).decode.should == '0075678164125'
        end

      end
    end
  end
end

