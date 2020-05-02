FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Company.bs }
    password_confirmation { password }

    confirmed_at { Time.now }

    factory :unconfirmed_user do
      confirmed_at nil
    end
  end
end
