require 'rails_helper'

RSpec.describe "conversations/new", :type => :view do
  before(:each) do
    assign(:conversation, Conversation.new())
  end

  it "renders new conversation form" do
    render

    assert_select "form[action=?][method=?]", conversations_path, "post" do
    end
  end
end
