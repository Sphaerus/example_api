require 'rails_helper'

RSpec.describe Country, type: :model do
  describe 'validations' do
    subject { country.valid? }
    context 'when target groups are not root nodes' do
      let(:country)         { build :country, target_groups: [target_group_1] }
      let(:target_group)    { create :target_group }
      let!(:target_group_1) { create :target_group, parent: target_group }

      it 'is invalid' do
        subject
        expect(country.errors.messages[:target_groups]).to include 'country can only have root target groups'
      end
    end
  end
end
