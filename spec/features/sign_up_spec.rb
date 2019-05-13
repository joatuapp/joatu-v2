require 'features_helper'
require 'session_helper'

feature "Sign Up" do
  background do
    # FactoryGirl.create(:user, email: "test@example.com", password: "testpass")
  end

  scenario "Create An Account" do
    visit "/"
    click_link "Sign Up"

    expect(page).to have_selector 'h2', text: "Sign Up"

    within("form#new_user") do
      fill_in "user[email]", with: 'new-user@grr.la'
      fill_in "user[password]", with: 'password'
      fill_in "user[password_confirmation]", with: 'password'
      check "user[tou_agreement]"
      click_button 'Sign Up'
    end


    expect(page).to have_selector 'div.alert.alert-success', text: "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account."
  end
end
