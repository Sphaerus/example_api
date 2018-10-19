# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthToken::Encoder do
  let(:user_id)         { rand(100) }
  let(:expiration_date) { Date.today }
  let(:body)            { { user_id: user_id, expiration_date: expiration_date } }
  let(:encoder)         { described_class.new }

  describe '#encode' do
    subject { encoder.encode(user_id: user_id, expiration_date: expiration_date) }

    it 'generates token based on user id and given date' do
      is_expected.to eq(JWT.encode(body, Rails.application.secrets.secret_key_base))
    end
  end
end
