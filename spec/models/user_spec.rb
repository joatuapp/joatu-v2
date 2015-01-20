require 'rails_helper'
require 'support/has_attribute'

RSpec.describe User, :type => :model do
  it_behaves_like "has attribute", :offers
end
