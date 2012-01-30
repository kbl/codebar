module Codebar
  module Standard
    module Ean13
      class Bars

        attr_reader :narrow_width, :normalized

        def initialize(code)
          @code = code
          split_code_into_sequences

          calculate_bar_width
          normalize
        end

        private

        def calculate_bar_width
          guard_bar_widths = (@code.slice(0, 3) + (@code.slice(-3, 3))).map(&:length)

          @narrow_width = guard_bar_widths
                            .reduce(Hash.new(0)) { |hash, value| 
                              hash[value] += 1
                              hash }
                            .max[0]
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

          @code = result
        end

        def normalize
          @normalized = []
          @code.each do |sequence|
            how_many_bars = sequence.length * 1.0 / @narrow_width
            how_many_bars.to_i.times { @normalized << sequence[0] }
          end
        end

      end
    end
  end
end
