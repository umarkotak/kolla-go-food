# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    name 'umar'
    title 'kurang pedas'
    description 'ini sambelnya kurang mantap'
    reviewable_type 'Food'
    reviewable_id 1
  end
end
