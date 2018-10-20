# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repository::User do
  let(:repository) { described_class.new }

  describe '#find!' do
    subject { repository.find!(user_id) }

    context 'when user exists' do
      let!(:user)   { create :user }
      let(:user_id) { user.id }

      it 'returns user' do
        expect(subject).to eq user
      end
    end

    context 'when user not found' do
      let(:user_id) { 12 }

      it 'raises an error' do
        expect { subject }.to raise_error ResourceNotFound
      end
    end
  end
end
