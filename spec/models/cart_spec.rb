require 'rails_helper'

RSpec.describe Cart, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

  it "has a valid factory" do
    expect(build(:cart)).to be_valid
  end

  it "deletes line_items when deleted" do
    cart = create(:cart)
    food1 = create(:food, name: 'Nasi Uduk')
    food2 = create(:food, name: 'Kerak Telor') 
    
    line_item1 = create(:line_item, cart: cart, food: food1)
    line_item2 = create(:line_item, cart: cart, food: food2)
    cart.line_items << line_item1
    cart.line_items << line_item2

    expect { cart.destroy }.to change { LineItem.count }.by(-2)
  end

  it "does not change the number of line item if the same food is added" do
    cart = create(:cart)
    food = create(:food, name: 'Nasi Uduk')
    line_item = create(:line_item, cart: cart, food: food)

    expect { cart.add_food(food) }.not_to change { LineItem.count }
  end

  it "increament the quantity of item if the same food is added" do
    cart = create(:cart)
    food = create(:food, name: "Nasi Uduk")
    line_item = create(:line_item, food: food, cart: cart)

    expect(cart.add_food(food).quantity).to eq(2)
  end

  it "will return the sum of the total price of its LineItem's" do
    cart = create(:cart)
    food = create(:food, name: "Nasi Uduk")
    line_item = create(:line_item, food: food, cart: cart)


  end

  it "can calculate total_price" do
    cart = create(:cart)
    food1 = create(:food, name: "Nasi Uduk", price: 5000)
    food2 = create(:food, name: "Nasi Kuning", price: 7000)
    line_item1 = create(:line_item, food: food1, quantity: 2, cart: cart)
    line_item2 = create(:line_item, food: food2, quantity: 1, cart: cart)

    expect(cart.total_price).to eq(17000)
  end

end
