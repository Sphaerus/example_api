# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repository::Location do
  let(:repository) { described_class.new }

  describe '#find_by_country' do
    subject { repository.find_by_country(country) }
    let(:panel_provider_id) { 1 }

    context 'when country dont exist' do
      let(:country) { nil }
      it 'returns empty result' do
        is_expected.to eq []
      end
    end

    context 'when country exist' do
      let!(:country) { create :country, panel_provider_id: panel_provider_id }
      let(:code)     { country.code }

      context 'when location groups dont exist' do
        let(:panel_provider) { create :panel_provider }

        it 'returns empty result' do
          is_expected.to eq []
        end
      end

      context 'when location groups exist' do
        let(:panel_provider)  { create :panel_provider }
        let!(:location_group) { create :location_group, country: country, panel_provider_id: panel_provider.id }

        context 'when locations exist' do
          let!(:location) { create :location, location_group: location_group }

          it 'returns array of locations' do
            is_expected.to eq [location]
          end
        end

        context 'when locations dont exist' do
          it 'returns empty result' do
            is_expected.to eq []
          end
        end
      end
    end
  end
end
