pw = Faker::Lorem.characters(10)

FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    password pw
    password_confirmation pw
  end
end
