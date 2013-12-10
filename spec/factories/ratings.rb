# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rating do
    name "thumbs up"
    association :user
    association :story
   end
end
