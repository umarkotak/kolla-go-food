require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it "has a valid factory" do
    expect(build(:restaurant)).to be_valid
  end

  it "is valid with name" do
    expect(build(:restaurant)).to be_valid
  end

  it "is invalid without name" do
    restaurant = build(:restaurant, name: nil)
    restaurant.valid?
    expect(restaurant.errors[:name]).to include("can't be blank")
  end

  it "is invalid without address" do
    restaurant = build(:restaurant, address: nil)
    restaurant.valid?
    expect(restaurant.errors[:address]).to include("can't be blank")
  end

  it "is invalid with duplicate name" do
    restaurant = create(:restaurant, name: 'kfc')
    restaurant2 = build(:restaurant, name: 'kfc')
    restaurant2.valid?
    expect(restaurant2.errors[:name]).to include("has already been taken")
  end

  it "can't be destroyed while it has food(s)" do
    restaurant = create(:restaurant)
    food = create(:food, restaurant: restaurant)

    expect { restaurant.destroy }.not_to change(Tag, :count)
  end
end
