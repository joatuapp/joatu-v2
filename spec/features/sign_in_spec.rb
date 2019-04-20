require 'features_helper'
require 'session_helper'

feature "Sign In" do
  background do
    FactoryGirl.create(:user, email: "test@example.com", password: "testpass")
  end

  scenario "Logging in from the login page" do
    sign_in_with('test@example.com', 'testpass')
    expect(page).to have_content "Signed in successfully"
  end

  scenario "Signing in from the home page with correct credentials" do
    visit "/"

    within("#nav_signin_form") do
      fill_in "Email", with: 'test@example.com'
      fill_in "Password", with: 'testpass'
    end

    click_button "Log In"
    expect(page).to have_content "Signed in successfully"
  end

  scenario "Sigining in from the home page with incorrect credentials" do
    visit "/"

    within("#nav_signin_form") do
      fill_in "Email", with: 'test@example.com'
      fill_in "Password", with: 'wrongpassword'
    end

    click_button "Log In"
    expect(page).to have_content "Invalid Email or password"
  end
end
