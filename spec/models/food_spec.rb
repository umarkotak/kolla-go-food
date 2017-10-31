require 'rails_helper'

describe Food do
  
  it "is valid with a name and description" do
    food = Food.new(
      name: 'Nasi Uduk',
      description: 'Betawi style steamed rice cooked in coconut milk.',
      price: 5000
    )
    expect(food).to be_valid
  end

  # it "is invalid without a name" do
  #   food = Food.new(
  #     name: nil,
  #     description: 'halo',
  #     price: 5000
  #   )
  #   food.valid?
  #   expect(food.errors[:name]).to include("can't be blank")
  # end

  # it "is invalid without a description" do
  #   food = Food.new(
  #     name: 'Nasi Jamblank',
  #     description: nil,
  #     price: 5000
  #   )
  #   food.valid?
  #   expect(food.errors[:description]).to include("can't be blank")
  # end

  # it "is invalid with a duplicate name" do
  #   food1 = Food.create(
  #     name: 'Nasi Uduk',
  #     description: 'Nasik enak',
  #     price: 5000
  #   )

  #   food2 = Food.new(
  #     name: 'Nasi Uduk',
  #     description: 'Nasik enak',
  #     price: 6000
  #   )

  #   food2.valid?
  #   expect(food2.errors[:name]).to include('has already been taken')
  # end

# ====================================================

  # without dry concept

  # it "returns a sorted array of results that match" do
  #   food1 = Food.create(
  #     name: 'Nasi Uduk',
  #     description: 'Nasi enak banget',
  #     price: 5000
  #   )

  #   food2 = Food.create(
  #     name: 'Kerak Telor',
  #     description: 'Telor di keraking',
  #     price: 15000
  #   )

  #   food3 = Food.create(
  #     name: 'Nasi Sambal',
  #     description: 'Nasi enak ajah',
  #     price: 5500
  #   )

  #   expect(Food.by_letter('N')).to eq([food3, food1])
  # end

  # it "returns a sorted array of results that match" do
  #   food1 = Food.create(
  #     name: 'Nasi Uduk',
  #     description: 'Nasi enak banget',
  #     price: 5000
  #   )

  #   food2 = Food.create(
  #     name: 'Kerak Telor',
  #     description: 'Telor di keraking',
  #     price: 15000
  #   )

  #   food3 = Food.create(
  #     name: 'Nasi Sambal',
  #     description: 'Nasi enak ajah',
  #     price: 5500
  #   )

  #   expect(Food.by_letter('N')).to eq([food3, food1])
  #   expect(Food.by_letter('N')).not_to eq([food2])
  # end

  # with dry concept

  # describe "filter name by letter" do
  #   before :each do
  #     @food1 = Food.create(
  #       name: 'Nasi Uduk',
  #       description: 'Nasi enak banget',
  #       price: 5000
  #     )

  #     @food2 = Food.create(
  #       name: 'Kerak Telor',
  #       description: 'Telor di keraking',
  #       price: 15000
  #     )

  #     @food3 = Food.create(
  #       name: 'Nasi Sambal',
  #       description: 'Nasi enak ajah',
  #       price: 5500
  #     )
  #   end

  #   context "with matching letter" do
  #     it "returns a sorted array of result that match" do
  #       expect(Food.by_letter('N')).to eq([@food3, @food1])
  #     end
  #   end

  #   context "with non-matching letter" do
  #     it "returns a sorted array of result that match" do
  #       expect(Food.by_letter('N')).not_to eq([@food2])
  #     end
  #   end
  # end

# ====================================================

  # it "is invalid when input include non numeric character" do
  #   food = Food.new(
  #     name: 'Nasi Uduk',
  #     description: 'Nasik enak sekali',
  #     price: '5000a'
  #   )
  #   food.valid?
  #   expect(food.errors[:price]).to include('is not a number')
  # end

  # it "is invalid when price < 0.01" do
  #   food = Food.new(
  #     name: 'Nasi Uduk',
  #     description: 'Nasik enak sekali',
  #     price: -5
  #   )
  #   food.valid?
  #   val = 0.01
  #   expect(food.errors[:price]).to include("must be greater than or equal to #{val}")
  # end

  # it "is invalid when image format other than .gif .jpg .png" do
  #   food = Food.new(
  #     name: 'Nasi Uduk',
  #     description: 'Nasik enak sekali',
  #     price: -5,
  #     image_url: 'ngakak.lol'
  #   )
  #   food.valid?
  #   expect(food.errors[:image_url]).to include('must be a URL for GIF, JPG or PNG image')
  # end

  # describe "dryer structur for precense" do
  #   before :each do
  #     @food = Food.new(
  #       name: nil,
  #       description: nil, 
  #       price: 5000
  #     )
  #   end

  #   context "with name precense" do
  #     it "is invalid without a name" do
  #       @food.valid?
  #       expect(@food.errors[:name]).to include("can't be blank")
  #     end
  #   end

  #   context "with description precense" do
  #     it "is invalid without a description" do
  #       @food.valid?
  #       expect(@food.errors[:description]).to include("can't be blank")
  #     end
  #   end
  # end

# ====================================================
  
  it "has a valid factory" do
    expect(FactoryGirl.build(:food)).to be_valid
  end

  it "is invalid without a name" do
    food = FactoryGirl.build(:food, name: nil)
    food.valid?
    expect(food.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a description" do
    food = FactoryGirl.build(:food, description: nil)
    food.valid?
    expect(food.errors[:description]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    food1 = FactoryGirl.create(:food, name: 'Nasi Uduk')
    food2 = FactoryGirl.build(:food, name: 'Nasi Uduk')

    food2.valid?
    expect(food2.errors[:name]).to include('has already been taken')
  end

# ====================================================

  it "has a valid factory" do
    expect(build(:food)).to be_valid
  end

  it "is invalid without a name" do
    food = build(:food, name: nil)
    food.valid?
    expect(food.errors[:name]).to include("can't be blank")
  end

  it "is invalid without a description" do
    food = build(:food, description: nil)
    food.valid?
    expect(food.errors[:description]).to include("can't be blank")
  end

  it "is invalid with a duplicate name" do
    food1 = create(:food, name: 'Nasi Uduk')
    food2 = build(:food, name: 'Nasi Uduk')
    
    food2.valid?
    expect(food2.errors[:name]).to include('has already been taken')
  end

# ====================================================

  it "is invalid when input include non numeric character" do
    food = build(:food, price: '5abc')
    food.valid?
    expect(food.errors[:price]).to include('is not a number')
  end

  it "is invalid when price < 0.01" do
    food = build(:food, price: -500)
    food.valid?
    val = 0.01
    expect(food.errors[:price]).to include("must be greater than or equal to #{val}")
  end

  it "is invalid when image format other than .gif .jpg .png" do
    food = build(:food, image_url: 'ngakak.lol')
    food.valid?
    expect(food.errors[:image_url]).to include('must be a URL for GIF, JPG or PNG image')
  end

  it "returns a sorted array of results that match" do
    food1 = create(:food, name: 'Nasi Uduk')
    food2 = create(:food, name: 'Kerak Telor')
    food3 = create(:food, name: 'Nasi Sambal')
    expect(Food.by_letter('N')).to eq([food3, food1])
    expect(Food.by_letter('N')).not_to eq([food2])
  end

  it "can't be destroyed while it has line_item(s)" do
    cart = create(:cart)
    food = create(:food)

    line_item = create(:line_item, cart: cart, food: food)
    food.line_items << line_item

    expect{ food.destroy }.not_to change(Food, :count)
  end

end