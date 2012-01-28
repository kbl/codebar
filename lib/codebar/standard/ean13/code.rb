module Codebar
  module Standard
    module Ean13
      class Code

        include Codebar::Image::Standard::Ean13

        NO_BARS_ENCODING_DIGIT = 7
        NO_DIGITS_ENCODED_IN_PART = 6

        CENTER_GUARD_NO_BARS= 5
        GUARD_NO_BARS= 3

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
          @bar_width = Bar.new(@code).narrow_width

          @left_part = code.slice(guard_width, part_width)
          right_part_beginning = guard_width + part_width + center_guard_width
          @right_part = code.slice(right_part_beginning, part_width)

          decode
        end

        def valid?
          not @decoded.nil?
        end

        def decode
          return @decoded if @decoded
          @left_part.each_slice(digit_width) do |digits|
            digits = normalize(digits)
          end

          @decoded
        end

        private

        def digit_width
          @bar_width * NO_BARS_ENCODING_DIGIT
        end

        def part_width
          digit_width * NO_DIGITS_ENCODED_IN_PART
        end

        def guard_width
          @bar_width * GUARD_NO_BARS
        end

        def center_guard_width
          @bar_width * CENTER_GUARD_NO_BARS
        end

        def normalize(digits)
          digits.each_slice(@bar_width) do |number|
          end
        end

      end
    end
  end
end
