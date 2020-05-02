require 'features_helper'
require 'session_helper'

feature "Admin Caps" do
  background do
    FactoryGirl.create(:user, email: "joatu-admin@grr.la", password: "password", is_admin: true)
  end

  # scenario "Visit caps page" do
  #   sign_in_with('joatu-admin@grr.la', 'password')
  #   visit admin_caps_path

  #   expect(page).to have_selector 'h2', text: "Caps"
  # end
end
