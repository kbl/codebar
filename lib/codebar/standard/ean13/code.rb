module Codebar
  module Standard
    module Ean13

      BarcodeDataCorruptedError = Class.new(RuntimeError)

      class Code

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

        # table representing odd/even types of encoding for first number
        # first 6 encoded digits (in left part of barcode) specifies 13 digit (first one)
        FIRST_DIGIT_ENCODING = {
          oooooo: '0',
          ooeoee: '1',
          ooeeoe: '2',
          ooeeeo: '3',
          oeooee: '4',
          oeeooe: '5',
          oeeeoo: '6',
          oeoeoe: '7',
          oeoeeo: '8',
          oeeoeo: '9'
        }

        def initialize(code)
          @bars       = Bars.new(code)
          @code       = @bars.normalized

          right_part_beginning = guard_width + part_width + center_guard_width
          @left_part  = @code.slice(guard_width, part_width)
          @right_part = @code.slice(right_part_beginning, part_width)

          decode
        end

        def valid?
          not @decoded.nil?
        end

        def decode
          return @decoded if @decoded
          
          @decoded            = ''
          @left_part_encoding = []

          @left_part.each_slice(digit_width) do |digits|
            @decoded += find_number(digits.join(''), :left)
          end
          @right_part.each_slice(digit_width) do |digits|
            @decoded += find_number(digits.join(''), :right)
          end

          prepend_first_digit
        end

        private

        def digit_width
          NO_BARS_ENCODING_DIGIT
        end

        def part_width
          digit_width * NO_DIGITS_ENCODED_IN_PART
        end

        def guard_width
          GUARD_NO_BARS
        end

        def center_guard_width
          CENTER_GUARD_NO_BARS
        end

        def find_number(sequence, side)
          # calling appropriate method for left/right side of bar code
          send("#{side}_side_number", sequence)
        end

        def left_side_number(sequence)
          number = nil

          SEQUENCES_LEFT.each do |notation, hash|
            if hash.has_key?(sequence)
              number = SEQUENCES_LEFT[notation][sequence]
              @left_part_encoding << notation.to_s[0]
              break
            end
          end

          number
        end

        def right_side_number(sequence)
          SEQUENCES_RIGHT[sequence]
        end

        def prepend_first_digit
          @left_part_encoding = @left_part_encoding.join('').to_sym

          @decoded = FIRST_DIGIT_ENCODING[@left_part_encoding] + @decoded
        end

      end
    end
  end
end
