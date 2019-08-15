FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password Faker::Lorem.characters(10)
    password_confirmation { password }

    confirmed_at { Time.now }

    factory :unconfirmed_user do
      confirmed_at nil
    end

    after(:create) do |user|
      create(:profile, user: user)
    end
  end
end
