require 'rails_helper'

describe LineItem do
  it "has a valid factory" do
    expect(build(:line_item)).to be_valid
  end

  # it "will return the calculation of LineItem's quantity times its Product's price" do
  #   line_item = build(:line_item)
  #   expect(line_item.total_price(2,5000)).to eq(10000)
  # end

  it "can calculate total_price" do
    food = create(:food, price: 10000)
    line_item = create(:line_item, quantity: 3, food: food)

    expect(line_item.total_price).to eq(30000)
  end
  
  
end