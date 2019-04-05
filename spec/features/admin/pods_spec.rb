require 'features_helper'
require 'session_helper'

feature "Admin Pods" do
  background do
    FactoryGirl.create(:user, email: "joatu-admin@grr.la", password: "password", is_admin: true)
  end

  scenario "Visit pods page" do
    sign_in_with('joatu-admin@grr.la', 'password')
    visit admin_pods_path

    expect(page).to have_selector 'h2', text: "Pods"
  end
end
