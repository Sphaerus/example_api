# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/target_groups' do
  describe 'api/target_groups' do
    subject do
      get '/api/target_groups', params: request_body, as: :json
    end
    let(:request_body)     { { country_code: country_code } }
    let(:country_code)     { country.code }
    let(:panel_provider)   { create :panel_provider }
    let(:panel_provider_1) { create :panel_provider, code: '10_arrays' }
    let!(:country)         { create :country, panel_provider: panel_provider }
    let!(:user)            { create :user }

    context 'when request authorized with auth token' do
      context 'when country dont exist' do
        let(:country_code) { 'usa!' }

        it 'returns empty result' do
          subject
          expect(response.body).to be_json_eql(<<-JSON)
            { "error": "Country not found" }
          JSON
        end
      end

      context 'when target groups dont exist' do
        let(:expected_result) { [] }
        it 'returns empty result' do
          subject
          expect(JSON.parse(response.body)).to eq(expected_result)
        end
      end

      context 'when target groups exist' do
        let!(:target_group)   { create :target_group, panel_provider: panel_provider, countries: [country] }
        let!(:target_group_1) { create :target_group, panel_provider: panel_provider_1, countries: [country] }
        let(:expected_result) do
          [
            {
              'name'              => target_group.name,
              'external_id'       => target_group.external_id,
              'parent_id'         => target_group.parent_id,
              'secret_code'       => target_group.secret_code,
              'panel_provider_id' => target_group.panel_provider_id
            }
          ]
        end

        it 'returns array of apropriate results' do
          subject
          expect(JSON.parse(response.body)).to eq(expected_result)
        end
      end
    end
  end
end
