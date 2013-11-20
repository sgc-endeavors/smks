# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :story do
    sequence(:title) { |i| "Baby#{i} Craps His Pants" }
    body "The body of the text"
    approved false
    association :user
    #user_id 1
    category_id 1
    picture_id 1
  end
end
