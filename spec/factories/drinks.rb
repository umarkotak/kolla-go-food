# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :drink do
    name {Faker::Food::dish}
    description {Faker::Food::ingredient}
    price {Faker::Number::number(3)}
    association :category
  end

  factory :invalid_drink, parent: :drink do
    name nil
    description nil
  end
end
