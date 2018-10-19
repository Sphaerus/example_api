# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/authenticate' do
  describe 'api/authenticate' do
    subject do
      post '/api/authenticate/', params: request_body
    end
    let(:request_body) { { email: email, password: password } }

    shared_examples 'returning error message' do
      it 'returns error message' do
        subject
        expect(response.body).to be_json_eql(<<-JSON)
          {"error": "You provided incorrect credentials"}
        JSON
      end
    end

    context 'when user doesnt exist' do
      let(:password) { 'incorrect password' }
      let(:email)    { 'email' }

      it_behaves_like 'returning error message'
    end

    context 'when user exists' do
      let!(:user)          { create :user }
      let(:expected_token) { AuthToken::Encoder.new.encode(user_id: user.id, expiration_date: Date.today + 1.days) }
      let(:email)          { user.email }
      let(:password)       { user.password }

      it 'returns token as response' do
        subject
        expect(response.body).to be_json_eql(<<-JSON)
          {"auth_token": "#{expected_token}"}
        JSON
      end

      context 'when password incorrect' do
        let(:password) { 'incorrect password' }

        it_behaves_like 'returning error message'
      end
    end
  end
end
