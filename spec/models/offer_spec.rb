require 'rails_helper'
require 'support/has_attribute'

RSpec.describe Offer, :type => :model do
  it_behaves_like "has attribute", :user
end
