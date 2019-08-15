
require 'rails_helper'

describe User, type: :model do
  let(:user) { create(:user) }
  subject { user }

  describe 'has a valid factory' do
    it { is_expected.to be_valid }
  end

  describe 'ActiveRecord associations' do
    describe 'profile' do
      it { is_expected.to have_one(:profile) }
      it { expect(user.profile).to be_present }
    end
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

  describe '#first_name' do
    it { is_expected.to respond_to(:first_name).with(0).arguments }
    it { expect(user.first_name).to eq(user.profile.given_name) }
  end

  describe '#last_name' do
    it { is_expected.to respond_to(:last_name).with(0).arguments }
    it { expect(user.last_name).to eq(user.profile.surname) }
  end
end
