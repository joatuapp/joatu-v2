require 'rails_helper'

RSpec.describe "profiles/show", :type => :view do
  before(:each) do
    @profile = assign(:profile, Profile.create!(
      :given_name => "Given Name",
      :surname => "Surname",
      :about_me => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Given Name/)
    expect(rendered).to match(/Surname/)
    expect(rendered).to match(/MyText/)
  end
end
