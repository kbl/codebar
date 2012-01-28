module Codebar
  module Standard
    module Ean13
      class Code

        include Codebar::Image::Standard::Ean13

        # hash of numbers, values represents [left odd, left even, right]
        NUMBERS = {'0' => ['0001101', '0100111', '1110010'],
                   '1' => ['0011001', '0110011', '1100110'],
                   '2' => ['0010011', '0011011', '1101100'],
                   '3' => ['0111101', '0100001', '1000010'],
                   '4' => ['0100011', '0011101', '1011100'],
                   '5' => ['0110001', '0111001', '1001110'],
                   '6' => ['0101111', '0000101', '1010000'],
                   '7' => ['0111011', '0010001', '1000100'],
                   '8' => ['0110111', '0001001', '1001000'],
                   '9' => ['0001011', '0010111', '1110100'] }

        def initialize(code)
          @code         = code
          @narrow_width = Bar.new(@code).narrow_width
          decode
        end

        def valid?
        end

        def decode
          return @decoded if @decoded
          check = Hash.new(0)
          @code.each_cons(@narrow_width) do |a, b|
            check[a == b] += 1
          end
          p check
        end

      end
    end
  end
end
