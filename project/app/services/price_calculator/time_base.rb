# frozen_string_literal: true

module PriceCalculator
  class TimeBase
    URL = 'http://time.com'
    private_constant :URL

    private

    def data
      @data ||= HTTParty.get(URL).to_s
    end
  end
end
