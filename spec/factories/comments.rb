# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    body "That was the funniest thing I've ever read..."
    approved false
    association :story
    association :user
  end
end
