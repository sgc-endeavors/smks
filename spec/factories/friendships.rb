# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :friendship do
    user_id 1
    friend_id 2
    hide_content false
  end
end
