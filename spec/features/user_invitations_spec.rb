require 'features_helper'
require 'session_helper'

feature "Invite Users" do
  background do
    FactoryGirl.create(:user, email: "joatu-admin@grr.la", password: "password", is_admin: true)
  end

  scenario "Visit Invite a new user page" do
    sign_in_with('joatu-admin@grr.la', 'password')
    visit new_user_invitation_path

    expect(page).to have_selector 'h2', text: "Send invitation"
  end

  scenario "Invite a new user" do
    sign_in_with('joatu-admin@grr.la', 'password')
    visit new_user_invitation_path

    within('form#new_user') do
      fill_in 'user[email]', with: 'testuser@grr.la'
      click_button 'create-invitation'
    end

    expect(page).to have_selector '.alert-success', text: "An invitation email has been sent to testuser@grr.la."
  end
end
