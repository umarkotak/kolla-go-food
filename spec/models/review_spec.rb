require 'rails_helper'

RSpec.describe Review, type: :model do
  it "has a valid with valid factory" do
    food = build(:food)
    expect(build(:review, reviewable: food)).to be_valid
  end

  it "is invalid without name" do
    review = build(:review, name: nil)
    review.valid?
    expect(review.errors[:name]).to include("can't be blank")
  end

  it "is invalid without title" do
    review = build(:review, title: nil)
    review.valid?
    expect(review.errors[:title]).to include("can't be blank")
  end

  it "is invalid without description" do
    review = build(:review, description: nil)
    review.valid?
    expect(review.errors[:description]).to include("can't be blank")
  end
end
