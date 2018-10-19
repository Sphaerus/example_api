# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthToken::Decoder do
  let(:user_id)         { rand(100) }
  let(:expiration_date) { Date.today }
  let(:body)            { { user_id: user_id, expiration_date: expiration_date } }
  let(:decoder)         { AuthToken::Decoder.new }
  let(:token) { AuthToken::Encoder.new.encode(user_id: user_id, expiration_date: expiration_date) }

  describe '#decode' do
    subject { decoder.decode(token: token) }
    context 'when token correct' do
      it 'returns user data', :aggregate_errors do
        expect(subject['user_id']).to eq(body[:user_id])
        expect(subject['expiration_date']).to eq(body[:expiration_date].to_s)
      end
    end

    context 'when token incorrect' do
      let(:token) { 'incorrect token' }

      it 'returns false' do
        is_expected.to eq false
      end
    end
  end
end
