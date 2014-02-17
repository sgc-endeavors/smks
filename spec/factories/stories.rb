# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :story do
    sequence(:title) { |i| "Baby#{i}'s First Day of School" }
    body "The body of the text is this long"
    approved false
    association :user
    association :kid
    share_type "public"
   #published_date Date.new(2012, 12, 3)
    category_id 1
  end
end
