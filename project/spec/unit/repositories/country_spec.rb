# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repository::Country do
  let(:repository) { described_class.new }

  describe '#find_by_country_code' do
    subject { repository.find_by_country_code!(code) }

    context 'when country exist' do
      let!(:country) { create :country }
      let(:code)     { country.code }

      it 'returns country' do
        is_expected.to eq country
      end
    end

    context 'when country doesnt exist' do
      let(:code) { 'incorrect code' }

      it 'raises error' do
        expect { subject }.to raise_error ResourceNotFound
      end
    end
  end
end
