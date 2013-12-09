# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating do
    name "Thumb's Up"
    association :user
    association :story
   end
end
