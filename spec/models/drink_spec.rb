require 'rails_helper'

RSpec.describe Drink, type: :model do
  it "is valid with a name and description" do
    expect(build(:drink)).to be_valid
  end

  it "is invalid without a name" do
    drink = build(:drink, name: nil)
    drink.valid?
    expect(drink.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a description" do
    drink = build(:drink, description: nil)
    drink.valid?
    expect(drink.errors[:description]).to include("can't be blank")
  end

  it "is invalid with duplicate name" do
    drink1 = create(:drink, name:'Cola')
    drink2 = build(:drink, name:'Cola')
    drink2.valid?
    expect(drink2.errors[:name]).to include('has already been taken')
  end

  it "is invalid when input include non numeric character" do
    drink = build(:drink, price: '5abc')
    drink.valid?
    expect(drink.errors[:price]).to include('is not a number')
  end

  it "is invalid when price < 0.01" do
    drink = build(:drink, price: -500)
    drink.valid?
    val = 0.01
    expect(drink.errors[:price]).to include("must be greater than or equal to #{val}")
  end

  it "is invalid when image format other than .gif .jpg .png" do
    drink = build(:drink, image_url: 'ngakak.lol')
    drink.valid?
    expect(drink.errors[:image_url]).to include('must be a URL for GIF, JPG or PNG image')
  end

  it "returns a sorted array of results that match" do
    drink1 = create(:drink, name: 'Nasi Uduk')
    drink2 = create(:drink, name: 'Kerak Telor')
    drink3 = create(:drink, name: 'Nasi Sambal')
    expect(Drink.by_letter('N')).to eq([drink3, drink1])
    expect(Drink.by_letter('N')).not_to eq([drink2])
  end
  
end
