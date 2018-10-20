# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Validator::Token do
  let(:validator)          { described_class.new(decoded_auth_token: decoded_auth_token) }
  let(:expiration_date)    { Date.today - 1.days }
  let(:decoded_auth_token) { { user_id: user_id, expiration_date: expiration_date.to_s } }
  let!(:user)              { create :user }
  let(:user_id)            { user.id }

  describe '#validate!' do
    subject { validator.validate! }

    context 'when expiration date passed' do
      it 'raises an error' do
        expect { subject }.to raise_error ValidationError
      end
    end

    context 'user id missing' do
      let(:decoded_auth_token) { { expiration_date: expiration_date.to_s } }

      it 'raises an error' do
        expect { subject }.to raise_error ValidationError
      end
    end

    context 'expiration date missing' do
      let(:decoded_auth_token) { { user_id: user_id } }
      it 'raises an error' do
        expect { subject }.to raise_error ValidationError
      end
    end
  end
end
