module Codebar
  module Standard
    module Ean13

      BarcodeDataCorruptedError = Class.new(RuntimeError)

      class Code

        include Codebar::Image::Standard::Ean13

        NO_BARS_ENCODING_DIGIT = 7
        NO_DIGITS_ENCODED_IN_PART = 6

        CENTER_GUARD_NO_BARS= 5
        GUARD_NO_BARS= 3

        # hash of numbers, values represents [left odd, left even, right]
        SEQUENCES_RIGHT = {
          '1110010' => '0',
          '1100110' => '1',
          '1101100' => '2',
          '1000010' => '3',
          '1011100' => '4',
          '1001110' => '5',
          '1010000' => '6',
          '1000100' => '7',
          '1001000' => '8',
          '1110100' => '9'
        }

        SEQUENCES_LEFT = {
          even: {
            '0100111' => '0',
            '0110011' => '1',
            '0011011' => '2',
            '0100001' => '3',
            '0011101' => '4',
            '0111001' => '5',
            '0000101' => '6',
            '0010001' => '7',
            '0001001' => '8',
            '0010111' => '9'
          },
          odd: { 
            '0001101' => '0',
            '0011001' => '1',
            '0010011' => '2',
            '0111101' => '3',
            '0100011' => '4',
            '0110001' => '5',
            '0101111' => '6',
            '0111011' => '7',
            '0110111' => '8',
            '0001011' => '9'
          }
        }

        def initialize(code)
          @code       = code
          @bar_width  = Bar.new(@code).narrow_width

          right_part_beginning = guard_width + part_width + center_guard_width
          @left_part  = code.slice(guard_width, part_width)
          @right_part = code.slice(right_part_beginning, part_width)

          decode
        end

        def valid?
          not @decoded.nil?
        end

        def decode
          return @decoded if @decoded
          
          @decoded = ''
          @left_part.each_slice(digit_width) do |digits|
            digits = normalize(digits)
            @decoded << find_number(digits.join(''), :left)
          end
          @right_part.each_slice(digit_width) do |digits|
            digits = normalize(digits)
            @decoded << find_number(digits.join(''), :right)
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
          digits.each_slice(@bar_width).map do |number|
            prev = number[0]
            number.each do |n|
              raise BarcodeDataCorruptedError unless n == prev
            end
            prev
          end
        end

        def find_number(sequence, side)
          case side
            when :left
              if @notation
                SEQUENCES_LEFT[@notation][sequence]
              else
                SEQUENCES_LEFT.each do |notation, hash|
                  if hash.has_key?(sequence)
                    @notation = notation
                    return SEQUENCES_LEFT[@notation][sequence]
                  end
                end
              end
            when :right
              SEQUENCES_RIGHT[sequence]
          end
        end

      end
    end
  end
end
