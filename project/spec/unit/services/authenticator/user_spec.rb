# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Authenticator::User do
  let(:authenticator) { described_class.new }

  describe '#legit?' do
    subject { authenticator.legit?(email: email, password: password) }
    context 'when user exists' do
      let!(:user)    { create :user }
      let(:email)    { user.email }
      let(:password) { user.password }

      it { is_expected.to eq user }
    end

    context 'when user doesnt exist' do
      let(:email)    { 'wrong email' }
      let(:password) { 'wrong password' }
      it { is_expected.to eq false }
    end
  end
end
