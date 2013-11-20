# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |i| "Joe#{i}" }
    sequence(:last_name) { |i| "Smith#{i}" }
    sequence(:email) { |i| "joe_smith#{i}@gmail.com" }
    password "iluvunicorns"
    terms true
    is_admin false
  end
end

