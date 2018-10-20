# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PriceCalculator::ArrayNumber do
  let(:calculator) { described_class.new }

  describe '#calculate_price' do
    subject { calculator.calculate_price }

    before do
      allow(HTTParty)
        .to receive(:get)
        .with('http://openlibrary.org/search.json?q=the+lord+of+the+rings')
        .and_return File.read('./spec/support/open_library.json')
    end

    it 'returns number of arrays holding more than then elements' do
      expect(subject).to eq 110
    end
  end
end
