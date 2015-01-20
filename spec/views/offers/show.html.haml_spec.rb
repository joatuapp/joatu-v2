require 'rails_helper'

RSpec.describe "offers/show", :type => :view do
  before(:each) do
    @offer = assign(:offer, Offer.create!(
      :title => "Title",
      :summary => "Summary",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Summary/)
    expect(rendered).to match(/MyText/)
  end
end
