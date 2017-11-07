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

  describe "payment with voucher" do
    before :each do
      @food = create(:food, price: 10000)
      @cart = create(:cart)      
      @line_item = create(:line_item, quantity: 3, food: @food, cart: @cart)

      @percentx = create(:voucher, kode: 'PERCENTXX', unit: 'percent', amount: 10, max_amount: 5000)
      @rupiahx = create(:voucher, kode: 'RUPIAHXX', unit: 'rupiah', amount: 10000, max_amount: 10000)
    end

    it "will return voucher id after inputing voucher_kode" do
      order = build(:order, voucher_kode: 'PERCENTXX')
      expect(order.find_voucher).to eq(1)
    end

    it "will return total discount with percent" do
      order = build(:order, voucher_kode: 'PERCENTXX')
      order.voucher_id = order.find_voucher
      order.add_line_items(@cart)

      order.save
      expect(order.total_discount).to eq(3000)
    end

    it "will return total discount with rupiah" do
      order = build(:order, voucher_kode: 'RUPIAHXX')
      order.voucher_id = order.find_voucher
      order.add_line_items(@cart)

      order.save
      expect(order.total_discount).to eq(10000)
    end

    it "will return 0 discount with invalid voucher" do
      order = build(:order, voucher_kode: 'ASALAJA')
      order.voucher_id = order.find_voucher
      order.add_line_items(@cart)

      order.save
      expect(order.total_discount).to eq(0)
    end

    it "will cut total amount with total discount percent" do
      order = build(:order, voucher_kode: 'PERCENTXX')
      order.voucher_id = order.find_voucher
      order.add_line_items(@cart)

      order.save
      # raise @line_item.to_json
      
      expect(order.total_payment).to eq(27000)
    end

    it "will cut total amount with total discount rupiah" do
      order = build(:order, voucher_kode: 'RUPIAHXX')
      order.voucher_id = order.find_voucher
      order.add_line_items(@cart)

      order.save
      # raise @line_item.to_json
      
      expect(order.total_payment).to eq(20000)
    end

    it "will cut with max_amount if discount > max_amount" do
      cart = create(:cart)      
      line_item = create(:line_item, quantity: 10, food: @food, cart: cart)      

      order = build(:order, voucher_kode: 'PERCENTXX')
       
      order.voucher_id = order.find_voucher
      order.add_line_items(cart)
      order.save

       expect(order.total_payment).to eq(95000)
    end
  end
end