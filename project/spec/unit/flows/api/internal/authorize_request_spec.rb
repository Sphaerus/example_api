# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Flow::Api::Internal::AuthorizeRequest do
  let(:flow)            { described_class.new(auth_token: auth_token) }
  let(:expiration_date) { Date.today }
  let!(:user)           { create :user }
  let(:user_id)         { user.id }
  let(:decoded_token)   { { user_id: user_id, expiration_date: expiration_date.to_s } }
  let(:auth_token)      { JWT.encode(decoded_token, Rails.application.secrets.secret_key_base) }

  describe '#call' do
    subject { flow.call }

    context 'when authorization token missing' do
      let(:auth_token) { nil }
      it { is_expected.to eq false }
    end

    context 'when authorization token expired' do
      let(:expiration_date) { Date.today - 1.days }
      it do
        expect { subject }.to raise_error ValidationError
      end
    end

    context 'when user doesnt exist' do
      let(:user_id) { 'fake' }

      it do
        expect { subject }.to raise_error ResourceNotFound
      end
    end

    context 'when authorization token valid' do
      context 'when user exists' do
        let(:auth_token) { JWT.encode(body, Rails.application.secrets.secret_key_base) }
        let(:body)       { { user_id: user.id, expiration_date: Date.today + 1.days } }
        let!(:user)      { create :user }
        it { is_expected.to eq user }
      end
    end
  end
end
