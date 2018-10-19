# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Authorizator::Request do
  let(:authorizator)  { described_class.new(headers: headers) }
  let(:headers)       { { 'auth_token' => auth_token } }
  let(:decoded_token) { { user_id: user.id } }
  let(:auth_token)    { 'auth_token' }

  describe '#authorized?' do
    subject { authorizator.authorized? }

    context 'when authorization token missing' do
      let(:auth_token) { nil }
      it { is_expected.to eq false }
    end

    context 'when authorization token invalid' do
      it { is_expected.to eq false }
    end

    context 'when authorization token valid' do
      context 'when user exists' do
        let(:auth_token) { JWT.encode(body, Rails.application.secrets.secret_key_base) }
        let(:body)       { { user_id: user.id, expiration_date: Date.today + 1.days } }
        let!(:user)      { create :user }
        it { is_expected.to eq true }
      end
    end
  end
end
