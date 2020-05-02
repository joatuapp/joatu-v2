# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pod do
    name { Faker::Company.name }
    description { Faker::Lorem.sentences(5) }
    focus_area { "POLYGON ((-73.57838988304138 45.51188068140241, -73.56929183006287 45.52306687976776, -73.57924818992615 45.52787746396651, -73.58989119529724 45.51669222205489, -73.57838988304138 45.51188068140241))" }

    before(:create) do |pod|
      pod.hub = FactoryGirl.create(:organization)
    end
  end
end
