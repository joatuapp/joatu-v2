require 'rails_helper'

RSpec.describe "messages/index", :type => :view do
  before(:each) do
    assign(:messages, [
      Message.create!(),
      Message.create!()
    ])
  end

  it "renders a list of messages" do
    render
  end
end
