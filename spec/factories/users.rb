# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    
    user_first "Joe"
    user_last "Smith"
    user_email "joe_smith@gmail.com"
    password "iluvunicorns"
    terms true
    is_admin false
  end

  factory :multiple_user, class: User do
    
    sequence(:user_first) { |i| "Joe#{i}" }
    sequence(:user_last) { |i| "Smith#{i}" }
    sequence(:user_email) { |i| "joe_smith#{i}@gmail.com" }
    password "iluvunicorns"
    terms true
    is_admin false
  end
end
