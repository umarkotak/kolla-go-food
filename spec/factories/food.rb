FactoryGirl.define do
  factory :food do
    name {Faker::Food::dish}
    description {Faker::Food::ingredient}
    price {Faker::Number::number(3)}
    category "Mahal"
    association :category

    # name "Nasi Uduk"
    # description "Nasi paling enak aja"
    # price 5000
  end

  factory :invalid_food, parent: :food do
    name nil
    description nil
    price 10000
  end
end