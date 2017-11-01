require 'rails_helper'

describe Order do
  it "has a valid factory" do
    expect(build(:order)).to be_valid
  end

  it "is valid with name, address, email, and payment_type" do
    expect(build(:order)).to be_valid
  end

  it "is invalid without a name" do
    order = build(:order, name: nil)
    order.valid?
    expect(order.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a address" do
    order = build(:order, address: nil)
    order.valid?
    expect(order.errors[:address]).to include("can't be blank")
  end

  it "is invalid without a email" do
    order = build(:order, email: nil)
    order.valid?
    expect(order.errors[:email]).to include("can't be blank")
  end

  it "is invalid with email not in valid email format" do
    order = build(:order, email: 'umar.umar.com')
    order.valid?
    expect(order.errors[:email]).to include("your email format is wrong")
  end

  it "is invalid without a payment_type" do
    order = build(:order, payment_type: nil)
    order.valid?
    expect(order.errors[:payment_type]).to include("can't be blank")
  end

  it "is invalid with wrong payment_type" do
    expect{build(:order, payment_type: "Grab Pay")}.to raise_error(ArgumentError)
  end

  # describe "adding line_item from cart" do
  #   it "add line_items to order" do
  #     order = create(:order)
  #     cart = create(:cart)
  #     food = create(:food)
  #     line_item = create(:line_item, food: food, cart: cart)

  #     expect( order.add_line_item(line_item) ).to change{ Order.count }.by(1)
      
  #   end

  #   it "removes line_items from cart" do

  #   end
  # end

  describe "adding line_item from cart" do
    before :each do
      @cart = create(:cart)
      @line_item = create(:line_item, cart: @cart)
      @order = build(:order)
    end

    it "add line_items to order" do
      expect{
        @order.add_line_items(@cart)
        @order.save  
      }.to change(@order.line_items, :count).by(1)      
    end

    it "removes line_items from cart" do
      expect{
        @order.add_line_items(@cart)
        @order.save
      }.to change(@cart.line_items, :count).by(-1)
    end
  end
end