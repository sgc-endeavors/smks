# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating do
    numeric_score 1
    association :user
    association :story
   end
end
