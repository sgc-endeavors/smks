# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :image do
    s3_image_loc "MyString"
    association :user
    association :story
  end
end
