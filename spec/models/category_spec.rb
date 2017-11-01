require 'rails_helper'

RSpec.describe Category, type: :model do
  it "has a valid factory" do
    expect(build(:category)).to be_valid
  end

  it "is valid with a name" do
    expect(build(:category)).to be_valid
  end

  it "is invalid without a name" do
    category = build(:category, name: nil)
    category.valid?
    expect(category.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    category1 = create(:category, name: "Dessert")
    category2 = build(:category, name: "Dessert")

    category2.valid?
    expect(category2.errors[:name]).to include("has already been taken")
  end
end
