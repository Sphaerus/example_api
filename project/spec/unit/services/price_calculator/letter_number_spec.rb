# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PriceCalculator::LetterNumber do
  let(:calculator) { described_class.new }

  describe '#calculate_price' do
    subject { calculator.calculate_price }

    before do
      allow(HTTParty)
        .to receive(:get)
        .with('http://time.com')
        .and_return File.read('./spec/support/time.txt')
    end

    it 'returns number of times "a" letter occures in the html' do
      expect(subject).to eq 1163
    end
  end
end
