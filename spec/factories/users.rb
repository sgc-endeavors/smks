# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    user_email "joe_smith@gmail.com"
    user_first "Joe"
    user_last "Smith"
    password "iluvunicorns"
    terms true
    is_admin false
  end
end
