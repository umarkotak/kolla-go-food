require 'rails_helper'

describe LineItem do
  it "has a valid factory" do
    expect(build(:line_item)).to be_valid
  end

  it "will return the calculation of LineItem's quantity times its Product's price"
  
  
end