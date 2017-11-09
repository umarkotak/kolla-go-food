require 'rails_helper'

RSpec.describe Tag, type: :model do
  it "has a valid factory" do
    expect(build(:tag)).to be_valid
  end

  it "is valid with name" do
    expect(build(:tag)).to be_valid
  end

  it "is invalid without name" do
    tag = build(:tag, name: nil)
    tag.valid?
    expect(tag.errors[:name]).to include("can't be blank")
  end

  it "is invalid with duplicate name" do
    tag = create(:tag, name: 'pedas')
    tag2 = build(:tag, name: 'pedas')
    tag2.valid?
    expect(tag2.errors[:name]).to include("has already been taken")
  end

  it "can't be destroyed while it has food(s)" do
    tag = create(:tag)
    food = create(:food)
    food_tag = create(:food_tag, food: food, tag: tag)

    expect { tag.destroy }.not_to change(Tag, :count)
  end
end
