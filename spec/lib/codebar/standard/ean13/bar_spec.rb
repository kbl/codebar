require 'spec_helper'

module Codebar
  module Image
    module Standard
      module Ean13
        describe Bar do

          it 'should find bar width' do
            # code encoded from 
            code = '1100100000010011110010000111110011110001111000110000111001111111001100011111001100100110011100001110011110011100001000000001001100111110001100001111100110000011000110011'
            Bar.new(code.split('')).narrow_width.should == 2
          end

        end
      end
    end
  end
end

