FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Company.bs }
    password_confirmation { password }

    confirmed_at { Time.now }

    factory :unconfirmed_user do
      confirmed_at nil
    end

    trait :profile do
      after(:create) do |user|
        user.profile = create(:profile, user: user)
      end

      after(:build) do |user|
        user.profile = build(:profile, user: user)
      end
    end
  end
end
