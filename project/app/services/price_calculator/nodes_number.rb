# frozen_string_literal: true

module PriceCalculator
  class NodesNumber < TimeBase
    NODES   = 'html, div, ul, li , p'
    DIVIDER = 100
    private_constant :NODES, :DIVIDER

    def calculate_price
      Float(parsed_result.css(NODES).count) / DIVIDER
    end

    private

    def parsed_result
      Nokogiri::HTML(data)
    end
  end
end
