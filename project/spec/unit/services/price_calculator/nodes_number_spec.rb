# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PriceCalculator::NodesNumber do
  let(:calculator) { described_class.new }

  describe '#calculate_price' do
    subject { calculator.calculate_price }

    before do
      allow(HTTParty)
        .to receive(:get)
        .with('http://time.com')
        .and_return File.read('./spec/support/time.txt')
    end

    it 'returns number of arrays holding more than then elements divided by 100' do
      expect(subject).to eq 0.18
    end
  end
end
