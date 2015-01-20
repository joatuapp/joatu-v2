# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :profile do
    given_name "MyString"
    surname "MyString"
    about_me "MyText"
  end
end
