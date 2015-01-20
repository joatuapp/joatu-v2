require 'rails_helper'
require 'support/has_attribute'

RSpec.describe Offer, :type => :model do
  it_behaves_like "has attribute", :user

  describe ".owned_by" do

    let(:user) { create(:user) }

    context "when there are offers owned by the given user" do

      let(:offer) { create(:offer, user: user) }

      it "returns them" do
        expect(described_class.owned_by(user)).to include offer
      end
    end

    context "when there are no offers owned by the given user" do

      it "returns an empty relation" do
        expect(described_class.owned_by(user)).to be_empty
      end
    end
  end
end
