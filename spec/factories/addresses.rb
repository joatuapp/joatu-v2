# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :address do
    address1 "MyString"
    address2 "MyString"
    city "MyString"
    province "MyString"
    country "MyString"
    postal_code "MyString"
  end
end
