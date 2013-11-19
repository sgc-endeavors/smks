# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    
    first_name "Joe"
    last_name "Smith"
    email "joe_smith@gmail.com"
    password "iluvunicorns"
    terms true
    is_admin false
  end

  factory :multiple_user, class: User do
    
    sequence(:first_name) { |i| "Joe#{i}" }
    sequence(:last_name) { |i| "Smith#{i}" }
    sequence(:email) { |i| "joe_smith#{i}@gmail.com" }
    password "iluvunicorns"
    terms true
    is_admin false
  end
end

#rename multiple_user to user (and delete user factory) because you can create
#a singular user from the sequence factory
