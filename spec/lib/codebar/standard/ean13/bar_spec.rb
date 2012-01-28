require 'spec_helper'

module Codebar
  module Image
    module Standard
      module Ean13
        describe Bar do

          it 'should find bar width' do
            # code encoded from ean13_clear2.jpg
            code = '1100110000001111001100111111001111001111000000110011001111111100111111001111001111001111110011001100111100001111001100110000000011001111110000111100001111001111001111000011000011111100110011'
            Bar.new(code.split('')).narrow_width.should == 2
          end

        end
      end
    end
  end
end

