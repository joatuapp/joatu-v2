require 'features_helper'
require 'session_helper'

feature "View Conversations" do
  background do
    FactoryGirl.create(:user, email: "test@example.com", password: "testpass")
  end

  scenario "View Conversations list" do
    sign_in_with('test@example.com', 'testpass')
    visit conversations_path
    expect(page).to have_selector 'h3', text: "Received Conversations"
  end
end
