# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Validator::GetPriceParams do
  let(:validator) { described_class.new(locations: locations) }

  describe '#validate!' do
    subject { validator.validate! }

    context 'when locations not an array' do
      let(:locations) { {} }
      it 'raises an error' do
        expect { subject }.to raise_error ValidationError
      end
    end

    context 'when locations have missing keys' do
      let(:locations) { [{ id: 1 }] }
      it 'raises an error' do
        expect { subject }.to raise_error ValidationError
      end
    end

    context 'when locations have incorrect values' do
      let(:locations) { [{ id: 1, panel_size: 'incorrect' }] }
      it 'raises an error' do
        expect { subject }.to raise_error ValidationError
      end
    end
  end
end
