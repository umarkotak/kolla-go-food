require 'rails_helper'

describe Food do
  it "is valid with a name and description" do
    food = Food.new(
      name: 'Nasi Uduk',
      description: 'Betawi style steamed rice cooked in coconut milk.',
      price: 5000
    )
    expect(food).to be_valid
  end

  it "is invalid without a name" do
    food = Food.new(
      name: nil,
      description: 'halo',
      price: 5000
    )
    food.valid?
    expect(food.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a description" do
    food = Food.new(
      name: 'Nasi Jamblank',
      description: nil,
      price: 5000
    )
    food.valid?
    expect(food.errors[:description]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    food1 = Food.create(
      name: 'Nasi Uduk',
      description: 'Nasik enak',
      price: 5000
    )

    food2 = Food.new(
      name: 'Nasi Uduk',
      description: 'Nasik enak',
      price: 6000
    )

    food2.valid?
    expect(food2.errors[:name]).to include('has already been taken')
  end

end