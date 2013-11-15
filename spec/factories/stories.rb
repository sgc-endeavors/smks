# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :story do
    title "Baby Gerard Craps His Pants at 1st Day of School"
    body "The body of the text"
    approved false
    user_id 1
    category_id 1
    picture_id 1
  end
end
