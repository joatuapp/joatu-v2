require 'features_helper'
require 'session_helper'

feature "View Offers" do
  background do
    FactoryGirl.create(:user, email: "test@example.com", password: "testpass")
  end

  scenario "View offers list" do
    sign_in_with('test@example.com', 'testpass')
    visit offers_path
    expect(page).to have_selector 'h1', text: "Offers"
  end

  scenario "Visit new offer page" do
    visit_new_offers_page
    expect(page).to have_content "Offer something new!"
  end

  scenario "Create new physical good offer" do
    create_new_offer

    expect(page).to have_selector 'h1', text: 'My First Offer'
  end

  scenario "Destroy an offer" do
    create_new_offer
    click_link 'destroy-offer'

    expect(page).to have_selector 'h1', text: 'Offers'
  end

  def visit_new_offers_page
    sign_in_with('test@example.com', 'testpass')
    visit offers_path
    click_link "Add A New Offer"
  end

  def create_new_offer
    visit_new_offers_page
    within('form#new_offer') do
      choose 'offer[type]', option: 'Offer::PhysicalGoods'
      fill_in 'offer[title]', with: 'My First Offer'
      fill_in 'offer[description]', with: 'My First description'
      select 'Everyone', from: 'offer[visibility]'
      click_button 'submit_offer'
    end
  end
end
