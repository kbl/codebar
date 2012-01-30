module Codebar
  module Standard
    module Ean13
      class Bar

        attr_reader :narrow_width

        def initialize(code)
          calculate_bar_width(code)
        end

        private

        def calculate_bar_width(code)
          previous = nil
          widths = []
          counter = 0

          code.each do |sign| 
            if previous == sign
              counter += 1
            elsif previous == nil
              previous = sign
              counter = 1
            else
              previous = sign
              widths << counter
              counter = 1
            end
          end
          widths << counter
          guard_bar_widths = widths.slice(0, 3) + (widths.slice(-3, 3))

          @narrow_width = guard_bar_widths
                            .reduce(Hash.new(0)) { |hash, value| 
                              hash[value] += 1
                              hash }
                            .max[0]
        end

      end
    end
  end
end
