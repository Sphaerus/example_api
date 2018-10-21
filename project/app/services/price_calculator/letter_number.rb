# frozen_string_literal: true

module PriceCalculator
  class LetterNumber < TimeBase
    SEARCHED_LETTER = 'a'
    private_constant :SEARCHED_LETTER

    def calculate_price
      data.count(SEARCHED_LETTER)
    end
  end
end
