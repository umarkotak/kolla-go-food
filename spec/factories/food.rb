FactoryGirl.define do
  factory :food do
    name {Faker::Food::dish}
    description {Faker::Food::ingredient}
    price {Faker::Number::number}

    # name "Nasi Uduk"
    # description "Nasi paling enak aja"
    # price 5000
  end
end