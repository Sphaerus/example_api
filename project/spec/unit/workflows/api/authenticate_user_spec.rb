# frozen_string_literal: true

require 'rails_helper'
require './app/flows/api/authenticate_user.rb'

RSpec.describe Flow::Api::AuthenticateUser do
  let(:flow) { described_class.new(email: email, password: password) }

  describe '#call' do
    subject { flow.call }

    context 'when user exists' do
      let!(:user)          { create :user }
      let(:email)          { user.email }
      let(:password)       { user.password }
      let(:token_body)     { { user_id: user.id, expiration_date: Date.today + 1.days } }
      let(:auth_token)     { JWT.encode(token_body, Rails.application.secrets.secret_key_base) }

      it 'returns auth token' do
        expect(subject).to eq(auth_token)
      end
    end

    context 'when user doesnt exists' do
      let(:email)    { 'fake email' }
      let(:password) { 'fake password' }
      it { is_expected.to eq false }
    end
  end
end
