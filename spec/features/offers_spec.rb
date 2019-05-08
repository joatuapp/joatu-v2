require 'features_helper'
require 'session_helper'
require 'support/conversations_helper'

feature "Offers" do
  background do
    create(:user, email: "test@example.com", password: "testpass")
  end

  scenario "View offers list" do
    sign_in_with('test@example.com', 'testpass')
    visit offers_path
    expect(page).to have_selector 'h1', text: "Offers"
  end

  scenario "Visit new offer page" do
    sign_in_with('test@example.com', 'testpass')
    visit_new_offers_page
    expect(page).to have_content "Offer something new!"
  end

  scenario "Create new physical good offer" do
    sign_in_with('test@example.com', 'testpass')
    create_new_offer

    expect(page).to have_selector 'h1', text: 'My First Offer'
  end

  scenario "Destroy an offer" do
    sign_in_with('test@example.com', 'testpass')
    create_new_offer
    click_link 'destroy-offer'

    expect(page).to have_selector 'h1', text: 'Offers'
  end

  scenario "Send a message about an offer" do
    sign_in_with('test@example.com', 'testpass')
    create_new_offer
    click_link 'Log Out'

    user = create(:user, email: "test@grr.la", password: "password")
    sign_in_with('test@grr.la', 'password')

    offer = Offer.where.not(id: user.offer_ids).first
    visit offer_path('en', offer)

    expect(page).to have_selector 'h1', text: 'My First Offer'
    expect(page).to have_selector 'a.send-message-btn'

    page.find('a.send-message-btn').click

    expect(page).to have_selector 'h3', text: 'Send Message'

    send_message('test subject', 'test body')

    expect(page).to have_selector 'h3', text: 'Sent Conversations'
    expect(page).to have_selector 'h3', text: 'test subject'
  end

  def visit_new_offers_page
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
