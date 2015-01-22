require 'rails_helper'

RSpec.describe "conversations/show", :type => :view do
  before(:each) do
    @conversation = assign(:conversation, Conversation.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
