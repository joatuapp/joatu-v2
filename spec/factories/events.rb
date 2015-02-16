# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "MyString"
    description "MyText"
    starts_at "2015-02-16 11:12:18"
    ends_at "2015-02-16 11:12:18"
  end
end
