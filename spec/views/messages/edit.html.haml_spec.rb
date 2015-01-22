require 'rails_helper'

RSpec.describe "messages/edit", :type => :view do
  before(:each) do
    @message = assign(:message, Message.create!())
  end

  it "renders the edit message form" do
    render

    assert_select "form[action=?][method=?]", message_path(@message), "post" do
    end
  end
end
