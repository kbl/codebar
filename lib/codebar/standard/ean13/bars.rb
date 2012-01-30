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
          raise BarcodeDataCorruptedError if @code.any?(&:nil?)

          prev = @code[0]
          sequence = ''
          sequences = []
          
          @code.each do |char|
            if char == prev
              sequence += char
            else
              sequences << sequence
              prev = char
              sequence = char
            end
          end
          sequences << sequence

          @code = sequences
        end

        # normalizes @code taking into account @bar_width
        # ie when @bar_width == 2 and @code == ['11', '00', '11', ...] then
        # @normalized == ['1', '0', '1', ...]
        def normalize
          @normalized = []
          @code.each do |sequence|
            how_many_bars = sequence.length * 1.0 / @narrow_width
            bar = sequence[0]
            how_many_bars.round.times { @normalized << bar }
          end
        end

      end
    end
  end
end
