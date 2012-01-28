require 'spec_helper'

module Codebar
  module Standard
    module Ean13
      describe Code do
        it 'should find bar size' do
          code = '1100100000010011110010000111110011110001111000110000111001111111001100011111001100100110011100001110011110011100001000000001001100111110001100001111100110000011000110011'
          Code.new(code.split(''))
        end
      end
    end
  end
end

