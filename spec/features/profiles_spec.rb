require 'features_helper'
require 'session_helper'

feature "User Profiles" do
  background do
    FactoryGirl.create(:user, email: "test@example.com", password: "testpass")
  end

  scenario "Create a profile" do
    sign_in_with('test@example.com', 'testpass')
    visit new_profile_path
    expect(page).to have_selector 'h1', text: "Create your JoatU profile"

    within('form#new_profile') do
      fill_in 'profile[given_name]', with: 'Example'
      fill_in 'profile[surname]', with: 'Profile'
      fill_in 'profile[about_me]', with: 'A cool test'
      click_button 'create-profile-btn'
    end

    expect(page).to have_selector 'h1', text: "Example Profile"
  end

  scenario "View a Profile" do
    user = FactoryGirl.create(:user, email: "joatu-test@example.com", password: "testpass")
    profile = user.create_profile(
      given_name: 'tester',
      surname: 'profile',
      about_me: 'this is some info about me'
    )

    sign_in_with('test@example.com', 'testpass')

    visit profile_url('en', profile)

    expect(page).to have_selector 'h1', text: "tester profile"
  end
end
