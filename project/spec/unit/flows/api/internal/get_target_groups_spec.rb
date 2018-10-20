# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Flow::Api::Internal::GetTargetGroups do
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
      let!(:panel_provider_1) { create :panel_provider }
      let!(:country)          { create :country, panel_provider: panel_provider }

      context 'when no target groups availble' do
        it 'returns empty result' do
          expect(subject).to eq []
        end
      end

      context 'when it has target_groups' do
        let!(:target_group)   { create :target_group, panel_provider: panel_provider, countries: [country] }
        let!(:target_group_1) { create :target_group, panel_provider: panel_provider_1, countries: [country] }

        it 'returns array of collections' do
          expect(subject).to eq [target_group]
        end
      end
    end
  end
end
