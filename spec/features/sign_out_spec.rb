require 'features_helper'
require 'session_helper'

feature "Sign Out" do
  background do
    FactoryGirl.create(:user, email: "test@example.com", password: "testpass")
  end

  scenario "Sign Out" do
    sign_in_with('test@example.com', 'testpass')
    expect(page).to have_content "Signed in successfully"
    click_link 'Log Out'
    expect(page).to have_selector 'h1', text: "Trade skills and goods to meet your needs, and create vibrant communities!"
  end
end
