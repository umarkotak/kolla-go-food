require 'rails_helper'

describe Buyer do

  it "is valid with a name, email, phone and address" do
    buyer = build(:buyer)
    expect(buyer).to be_valid
  end

  it "is invalid whitout a name" do
    buyer = build(:buyer, name: nil)
    buyer.valid?
    expect(buyer.errors[:name]).to include("can't be blank")
  end

  it "is invalid whitout an email" do
    buyer = build(:buyer, email: nil)
    buyer.valid?
    expect(buyer.errors[:email]).to include("can't be blank")
  end

  it "is invalid whitout a phone" do
    buyer = build(:buyer, phone: nil)
    buyer.valid?
    expect(buyer.errors[:phone]).to include("can't be blank")
  end

  it "is invalid whitout an address" do
    buyer = build(:buyer, phone: nil)
    buyer.valid?
    expect(buyer.errors[:phone]).to include("can't be blank")
  end

  it "is invalid when phone is non numeric and not equal 12 character long" do
    buyer = build(:buyer, phone: '0852172516aba')
    buyer.valid?
    expect(buyer.errors[:phone]).to include("is not a number")
    expect(buyer.errors[:phone]).to include("must be 12 characters") 
  end

  it "is invalid when the email format is wrong" do
    buyer = build(:buyer, email: 'umarkotak.haha.id')
    buyer.valid?
    expect(buyer.errors[:email]).to include("your email format is wrong")
  end

end