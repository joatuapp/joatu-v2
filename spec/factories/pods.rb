# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pod do
    name { Faker::Company.name }
    description { Faker::Lorem.sentences(5) }
    focus_area { RGeo::Geos.factory.parse_wkt("POLYGON((-149.737965876574 61.1952881991104, -149.71848377896 61.1953198415937, -149.718483761252 61.1952938698801, -149.718483872402 61.1951924591105, -149.737965876574 61.1952881991104))") }
  end
end
