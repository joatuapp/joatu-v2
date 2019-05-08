
require 'rails_helper'

describe User, type: :model do
  let(:user) { build(:user) }
  subject { user }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do
    it { is_expected.to have_one(:profile) }
    it { is_expected.to have_one(:pod_membership) }
    it { is_expected.to have_one(:pod) }

    it { is_expected.to have_many(:offers) }
    it { is_expected.to have_many(:requests) }
  end

  describe 'ActiveModel validations' do
  end

  describe 'callbacks' do
    it { is_expected.to callback(:update_home_location).before(:validation) }
    it { is_expected.to callback(:publish_location_updated).after(:save) }
  end
end
