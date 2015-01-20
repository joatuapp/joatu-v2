require 'rails_helper'

RSpec.describe "profiles/edit", :type => :view do
  before(:each) do
    @profile = assign(:profile, Profile.create!(
      :given_name => "MyString",
      :surname => "MyString",
      :about_me => "MyText"
    ))
  end

  it "renders the edit profile form" do
    render

    assert_select "form[action=?][method=?]", profile_path(@profile), "post" do

      assert_select "input#profile_given_name[name=?]", "profile[given_name]"

      assert_select "input#profile_surname[name=?]", "profile[surname]"

      assert_select "textarea#profile_about_me[name=?]", "profile[about_me]"
    end
  end
end
