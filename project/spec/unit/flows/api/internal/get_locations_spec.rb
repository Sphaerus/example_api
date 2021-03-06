# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Flow::Api::Internal::GetLocations do
  let(:flow)            { described_class.new(country_code: country_code) }
  let(:country_code)    { country.code }

  describe '#call' do
    subject { flow.call }

    context 'when country dont exist' do
      let(:country_code) { 'uk' }
      it 'raises error' do
        expect { subject }.to raise_error ResourceNotFound, 'Country not found'
      end
    end

    context 'when country exist' do
      let!(:panel_provider)   { create :panel_provider }
      let!(:panel_provider_1) { create :panel_provider, code: 'code1' }
      let!(:country)          { create :country, panel_provider: panel_provider }

      context 'when no locations availble' do
        it 'returns empty result' do
          expect(subject).to eq []
        end
      end

      context 'when it has location groups and locations with apropriate panel provider' do
        let!(:location_group)   { create :location_group, panel_provider: panel_provider, country: country }
        let!(:location)         { create :location, location_group: location_group }
        let!(:location_group_1) { create :location_group, panel_provider: panel_provider_1, country: country }
        let!(:location_1)       { create :location, location_group: location_group_1, external_id: 11 }

        it 'returns array of collections' do
          expect(subject).to eq [location]
        end
      end
    end
  end
end
