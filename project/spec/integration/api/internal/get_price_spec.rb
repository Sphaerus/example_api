# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /api/internal/price' do
  describe 'api/internal/price' do
    subject do
      get '/api/internal/price', params: request_body, headers: headers, as: :json
    end
    let(:headers) { {} }
    let(:locations) do
      [
        {
          id:         1,
          panel_size: 200
        }
      ]
    end
    let(:target_group_id)  { rand(999) }
    let(:country_code)     { country.code }
    let(:request_body)     do
      {
        locations:       locations,
        country_code:    country_code,
        target_group_id: target_group_id
      }
    end
    let(:panel_provider)   { create :panel_provider }
    let!(:country)         { create :country, panel_provider: panel_provider }
    let!(:user)            { create :user }

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

      before do
        allow(HTTParty)
          .to receive(:get)
          .with('http://time.com')
          .and_return File.read('./spec/support/time.txt')
      end

      context 'when panel provider' do
        let(:panel_code) { 'times_a' }

        it 'returns proper price based on panel provider' do
          subject
          expect(response.body).to be_json_eql(<<-JSON)
            { "price": 1163 }
          JSON
        end
      end
    end
  end
end
