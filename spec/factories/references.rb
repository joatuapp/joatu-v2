# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reference do
    from ""
    to ""
    reference "MyText"
    rating 1
    offer ""
  end
end
