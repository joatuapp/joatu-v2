# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pod do
    name "MyString"
    description "MyText"
    focus_area ""
    hub_id 1
  end
end
