require 'rails_helper'

RSpec.describe "references/edit", :type => :view do
  before(:each) do
    @reference = assign(:reference, Reference.create!(
      :from => "",
      :to => "",
      :reference => "MyText",
      :rating => 1,
      :offer => ""
    ))
  end

  it "renders the edit reference form" do
    render

    assert_select "form[action=?][method=?]", reference_path(@reference), "post" do

      assert_select "input#reference_from[name=?]", "reference[from]"

      assert_select "input#reference_to[name=?]", "reference[to]"

      assert_select "textarea#reference_reference[name=?]", "reference[reference]"

      assert_select "input#reference_rating[name=?]", "reference[rating]"

      assert_select "input#reference_offer[name=?]", "reference[offer]"
    end
  end
end
