require 'features_helper'
require 'session_helper'

feature "View Requests" do
  background do
    FactoryGirl.create(:user, email: "test@example.com", password: "testpass")
  end

  scenario "View requests list" do
    sign_in_with('test@example.com', 'testpass')
    visit requests_path
    expect(page).to have_selector 'h1', text: "Current Requests"
  end

  scenario "Visit new request page" do
    visit_new_requests_page
    expect(page).to have_selector 'h1', text: "Request Something From the Community!"
  end

  scenario "Create new physical good request" do
    create_new_request
    click_link 'destroy-request'

    expect(page).to have_selector 'h1', text: 'Requests'
  end

  def visit_new_requests_page
    sign_in_with('test@example.com', 'testpass')
    visit requests_path
    click_link "Add A New Request"
  end

  def create_new_request
    visit_new_requests_page
    within('form#new_request') do
      choose 'request[type]', option: 'Request::PhysicalGoods'
      fill_in 'request[title]', with: 'My First Request'
      fill_in 'request[description]', with: 'My First description'
      select 'Everyone', from: 'request[visibility]'
      click_button 'submit_request'
    end
  end
end
