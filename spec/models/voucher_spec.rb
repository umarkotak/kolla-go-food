require 'rails_helper'

RSpec.describe Voucher, type: :model do
  it "has a valid factory" do
    expect(build(:voucher)).to be_valid  
  end

  it "must uppercase character for kode" do
    voucher = build(:voucher, kode: 'PERCENTX')
    voucher.valid?
    expect(voucher).to be_valid
  end

  it "must convert lowercase to uppercase for input kode" do
    voucher = create(:voucher, kode: 'percentx')
    expect(voucher.kode).to eq('PERCENTX')
  end

  context "valid_from and valid_through" do

    it "is invalid without valid_from attribute" do
      voucher = build(:voucher, valid_from: nil)
      voucher.valid?
      expect(voucher.errors[:valid_from]).to include("can't be blank")
    end

    it "is invalid without valid_through attribute" do
      voucher = build(:voucher, valid_through: nil)
      voucher.valid?
      expect(voucher.errors[:valid_through]).to include("can't be blank")
    end

    # it "is invalid without date format" do
    #   voucher = build(:voucher, valid_from: '20-12-2017')
    #   voucher.valid?
    #   expect(voucher.errors[:valid_from]).to include
    # end
  end

  it "is invalid with negative amount attribute" do
    voucher = build(:voucher, amount: -5000)
    voucher.valid?
    expect(voucher.errors[:amount]).to include('must be greater than 0')
  end

  it "is invalid without unit contain rupiah or percent" do
    voucher = build(:voucher, unit: 'buah')
    voucher.valid?
    expect(voucher.errors[:unit]).to include('buah is not a valid unit')
  end

  context "unit calculation" do
    it "calculate percent" do
      voucher = build(:voucher, unit: 'percent')
      expect(voucher.voucher_value).to eq('percent')
    end

    it "calculate rupiah" do
      voucher = build(:voucher, unit: 'rupiah')
      expect(voucher.voucher_value).to eq('rupiah')
    end
  end

  it "is invalid without max_amount" do
    voucher = build(:voucher, max_amount: nil)
    voucher.valid?
    expect(voucher.errors[:max_amount]).to include("can't be blank")
  end

  it "return max_amount if discount > max_amount" do
    
  end

end
