# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    name {Faker::Number::number(3)}
  end

  factory :invalid_category do
    name nil
  end
end
