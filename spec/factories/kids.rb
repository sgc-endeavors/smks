# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :kid do
    name "Junior"
  	birthdate Date.new(2011, 12, 5)
    association :user
  end
end
