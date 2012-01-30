module Codebar
  module Standard
    module Ean13
      class Bars

        NUMBER_OF_BARS = 95

        attr_reader :narrow_width, :normalized

        def initialize(code)
          @code = code
          split_code_into_sequences

          calculate_bar_width
          normalize
        end

        private

        def calculate_bar_width
          @narrow_width = (@code.join('').length * 1.0 / NUMBER_OF_BARS).round
        end

        def split_code_into_sequences
          prev = @code[0]
          sequence = ''
          result = []
          
          @code.each do |char|
            if char == prev
              sequence += char
            else
              result << sequence
              prev = char
              sequence = char
            end
          end
          result << sequence

          @code = result
        end

        def normalize
          @normalized = []
          @code.each do |sequence|
            how_many_bars = sequence.length * 1.0 / @narrow_width
            how_many_bars.round.times { @normalized << sequence[0] }
          end
        end

      end
    end
  end
end
