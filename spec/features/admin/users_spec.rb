require 'features_helper'
require 'session_helper'

feature "Admin Users" do
  background do
    FactoryGirl.create(:user, email: "joatu-admin@grr.la", password: "password", is_admin: true)
  end

  scenario "Visit users page" do
    sign_in_with('joatu-admin@grr.la', 'password')
    visit admin_users_path

    expect(page).to have_selector 'h2', text: "Users"
    expect(page).to have_selector 'td.col-email', text: "joatu-admin@grr.la"
  end
end
