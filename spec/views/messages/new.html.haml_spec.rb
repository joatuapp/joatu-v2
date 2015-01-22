require 'rails_helper'

RSpec.describe "messages/new", :type => :view do
  before(:each) do
    assign(:message, Message.new())
  end

  it "renders new message form" do
    render

    assert_select "form[action=?][method=?]", messages_path, "post" do
    end
  end
end
