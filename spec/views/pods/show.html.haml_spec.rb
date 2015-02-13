require 'rails_helper'

RSpec.describe "pods/show", :type => :view do
  before(:each) do
    @pod = assign(:pod, Pod.create!(
      :name => "Name",
      :description => "MyText",
      :focus_area => "",
      :hub_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(/1/)
  end
end
