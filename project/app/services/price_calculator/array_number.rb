# frozen_string_literal: true

module PriceCalculator
  class ArrayNumber
    URL            = 'http://openlibrary.org/search.json?q=the+lord+of+the+rings'
    DOCS           = 'docs'
    MIN_ARRAY_SIZE = 10
    INITIAL_COUNT  = 1
    private_constant :URL, :DOCS, :MIN_ARRAY_SIZE, :INITIAL_COUNT

    def calculate_price
      counter = INITIAL_COUNT
      data[DOCS].each do |hash|
        hash.each do |_key, value|
          counter += 1 if value.is_a?(Array) && value.count > MIN_ARRAY_SIZE
        end
      end
      counter
    end

    private

    def data
      @data ||= JSON.parse HTTParty.get(URL)
    end
  end
end
