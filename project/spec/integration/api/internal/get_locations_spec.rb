# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/internal/locations' do
  describe 'api/internal/locations' do
    subject do
      get '/api/internal/locations', params: request_body, headers: headers, as: :json
    end
    let(:headers)        { {} }
    let(:request_body)   { { country_code: country_code } }
    let(:country_code)   { country.code }
    let(:panel_provider) { create :panel_provider }
    let!(:country)       { create :country, panel_provider: panel_provider }
    let!(:user)          { create :user }

    context 'when request not authorized' do
      it 'return incorrect token error' do
        subject
        expect(response.body).to be_json_eql(<<-JSON)
          {"error": "Incorrect or missing token"}
        JSON
      end
    end

    context 'when request authorized with auth token' do
      let(:date)       { Date.today }
      let(:body)       { { user_id: user.id, expiration_date: date } }
      let(:auth_token) { JWT.encode(body, Rails.application.secrets.secret_key_base) }
      let(:headers)    { { auth_token: auth_token } }
      let!(:user)      { create :user }

      context 'when country dont exist' do
        let(:country_code) { 'usa!' }

        it 'returns empty result' do
          subject
          expect(response.body).to be_json_eql(<<-JSON)
            { "error": "Country not found" }
          JSON
        end
      end

      context 'when locations dont exist' do
        let(:expected_result) { [] }
        it 'returns empty result' do
          subject
          expect(JSON.parse(response.body)).to eq(expected_result)
        end
      end

      context 'when locations exist' do
        let!(:location_group) { create :location_group, panel_provider: panel_provider, country: country }
        let!(:location)       { create :location, location_group: location_group }
        let(:expected_result) do
          [
            {
              'external_id'       => location.external_id,
              'location_group_id' => location.location_group_id,
              'name'              => location.name,
              'secret_code'       => location.secret_code
            }
          ]
        end

        it 'returns array of results' do
          subject
          expect(JSON.parse(response.body)).to eq(expected_result)
        end
      end
    end
  end
end
