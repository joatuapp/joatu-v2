require 'rails_helper'

RSpec.describe "references/show", :type => :view do
  before(:each) do
    @reference = assign(:reference, Reference.create!(
      :from => "",
      :to => "",
      :reference => "MyText",
      :rating => 1,
      :offer => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(//)
  end
end
