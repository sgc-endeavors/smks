# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :kid do
    name "Junior"
    association :user
  end
end
