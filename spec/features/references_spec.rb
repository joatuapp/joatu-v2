require 'features_helper'
require 'session_helper'

feature "Profile References" do
  background do
    FactoryGirl.create(:user, email: "test@example.com", password: "testpass")
  end

  scenario "Create a Reference" do
    user = FactoryGirl.create(:user, email: "joatu-test@example.com", password: "testpass")
    profile = user.create_profile(
      given_name: 'tester',
      surname: 'profile',
      about_me: 'this is some info about me'
    )

    sign_in_with('test@example.com', 'testpass')

    visit profile_url('en', profile)

    expect(page).to have_selector 'h1', text: "tester profile"

    click_link 'new-reference-btn'

    within('form#new_reference') do
      fill_in 'reference[reference]', with: 'Tester is a really great tester'
      select '5', from: 'reference[rating]'
      click_button 'create-reference-btn'
    end

    expect(page).to have_selector 'div.reference.panel > .panel-body > p:first-child', text: "Tester is a really great tester"
  end
end
