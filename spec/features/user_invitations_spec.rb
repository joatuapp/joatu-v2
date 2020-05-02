require 'features_helper'
require 'session_helper'

feature "Invite Users" do
  background do
    FactoryGirl.create(:user, email: "joatu-admin@grr.la", password: "password", is_admin: true)
  end

  scenario "Invite a new user" do
    sign_in_with('joatu-admin@grr.la', 'password')
    visit new_user_invitation_path
    expect(page).to have_selector 'h2', text: "Send invitation"

    within('form#new_user') do
      fill_in 'user[email]', with: 'testuser@grr.la'
      click_button 'create-invitation'
    end

    expect(page).to have_selector '.alert-success', text: "An invitation email has been sent to testuser@grr.la."
  end

  scenario "Accept an invitation sucessfully" do
    # byebug
    pod = FactoryGirl.create(:pod)
    user = User.invite!(email: 'testuser@grr.la')
    user.profile = FactoryGirl.create(:profile)
    raw, enc = Devise.token_generator.generate(user.class, :invitation_token)
    user.invitation_token = enc
    user.save!

    url = accept_user_invitation_url(user, format: :html, locale: :en, invitation_token: raw)

    visit url

    expect(page).to have_selector 'h2', text: "Set your password"
    expect(page).to have_selector 'select#user_pod_id'

    within('form#edit_user') do
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      # select Pod.first.id from: 'user_pod_id'
      check 'user[tou_agreement]'
      click_button 'accept-invitation'
    end

    expect(page).to have_selector 'h3', text: "About this Pod", wait: 10
  end

  scenario "Try to accept an invitation but fail password confirmation" do
    # byebug
    user = User.invite!(email: 'testuser@grr.la')
    user.profile = FactoryGirl.create(:profile)
    raw, enc = Devise.token_generator.generate(user.class, :invitation_token)
    user.invitation_token = enc
    user.save!

    url = accept_user_invitation_url(user, format: :html, locale: :en, invitation_token: raw)

    visit url

    expect(page).to have_selector 'h2', text: "Set your password"

    within('form#edit_user') do
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password123'
      # fill_in 'user[postal_code]', with: 'H2X 2T6'
      check 'user[tou_agreement]'
      click_button 'Set my password'
    end

    expect(page).to have_selector 'span.help-block', text: "Password mismatch"
  end
end

