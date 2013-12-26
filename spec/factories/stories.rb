# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :story do
    sequence(:title) { |i| "Baby#{i}'s First Day of School" }
    body "The body of the text is this long"
    approved false
    association :user
    #user_id 1
    share_type "public"
    category_id 1
    picture_id 1
  end
end
