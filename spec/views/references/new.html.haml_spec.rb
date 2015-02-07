require 'rails_helper'

RSpec.describe "references/new", :type => :view do
  before(:each) do
    assign(:reference, Reference.new(
      :from => "",
      :to => "",
      :reference => "MyText",
      :rating => 1,
      :offer => ""
    ))
  end

  it "renders new reference form" do
    render

    assert_select "form[action=?][method=?]", references_path, "post" do

      assert_select "input#reference_from[name=?]", "reference[from]"

      assert_select "input#reference_to[name=?]", "reference[to]"

      assert_select "textarea#reference_reference[name=?]", "reference[reference]"

      assert_select "input#reference_rating[name=?]", "reference[rating]"

      assert_select "input#reference_offer[name=?]", "reference[offer]"
    end
  end
end
