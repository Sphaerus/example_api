# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PanelProvider, type: :model do
  describe '#set_calculator_class' do
    let!(:panel_provider) { create :panel_provider, code: code}
    subject { panel_provider.set_calculator_class }

    context 'when code times_a' do
      let(:code) { 'times_a' }
      it { is_expected.to eq PriceCalculator::LetterNumber }
    end

    context 'when code 10_arrays' do
      let(:code) { '10_arrays' }
      it { is_expected.to eq PriceCalculator::ArrayNumber }
    end

    context 'when code times_html' do
      let(:code) { 'times_html' }
      it { is_expected.to eq PriceCalculator::NodesNumber }
    end
  end
end
