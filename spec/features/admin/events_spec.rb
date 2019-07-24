require 'features_helper'
require 'session_helper'

feature "Admin Events" do
  background do
    FactoryGirl.create(:user, email: "joatu-admin@grr.la", password: "password", is_admin: true)
  end

  scenario "Visit events page" do
    sign_in_with('joatu-admin@grr.la', 'password')
    visit admin_events_path

    expect(page).to have_selector 'h2', text: "Events"
  end

  scenario "Create a new event" do
    sign_in_with('joatu-admin@grr.la', 'password')
    visit admin_events_path

    expect(page).to have_selector 'h2', text: "Events"

    click_link 'New Event'

    expect(page).to have_selector 'h2', text: "New Event"
  end
end
