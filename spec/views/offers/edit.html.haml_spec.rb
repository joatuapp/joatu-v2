require 'rails_helper'

RSpec.describe "offers/edit", :type => :view do
  before(:each) do
    @offer = assign(:offer, Offer.create!(
      :title => "MyString",
      :summary => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit offer form" do
    render

    assert_select "form[action=?][method=?]", offer_path(@offer), "post" do

      assert_select "input#offer_title[name=?]", "offer[title]"

      assert_select "input#offer_summary[name=?]", "offer[summary]"

      assert_select "textarea#offer_description[name=?]", "offer[description]"
    end
  end
end
