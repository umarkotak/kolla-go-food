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

  it "is invalid with duplicate code" do
    voucher1 = create(:voucher, kode: 'percentx')
    voucher2 = build(:voucher, kode: 'percentX')
    voucher2.valid?

    expect(voucher2.errors[:kode]).to include("has already been taken")
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

    it "is invalid if valid_through < valid_from" do
      voucher = build(:voucher, valid_from: '2017-01-02', valid_through: '2017-01-01')
      voucher.valid?
      expect(voucher.errors[:valid_through]).to include("must be greater than valid_from")
    end

    it "is invalid with wrong date format" do
      voucher = build(:voucher, valid_from: '2015-14-45')
      voucher.valid?
      expect(voucher.errors[:valid_from]).to include("must be in yyyy-mm-dd format")
    end
  end

  it "can't be destroyed while it has order(s)" do
    voucher = create(:voucher)
    order = create(:order, voucher: voucher)

    expect { voucher.destroy }.not_to change(Voucher, :count)
  end

  context "with unit value rupiah" do
    it "is invalid with max_amount less than amount" do
      voucher = build(:voucher, unit: 'rupiah', amount: 5000, max_amount: 3000)
      voucher.valid?
      # raise voucher.errors.to_json
      expect(voucher.errors[:max_amount]).to include("must be greater than or equal to 5000.0")
    end
  end

  it "is invalid with negative amount attribute" do
    voucher = build(:voucher, amount: 0)
    voucher.valid?
    expect(voucher.errors[:amount]).to include('must be greater than 0')
  end

  it "is invalid with wrong unit" do
    voucher = build(:voucher, unit: 'buah')
    voucher.valid?
    expect(voucher.errors[:unit]).to include('buah is not a valid unit')
  end

  context "unit calculation" do
    it "calculate percent" do
      voucher = build(:voucher, unit: 'percent')
      expect(voucher.unit).to eq('percent')
    end

    it "calculate rupiah" do
      voucher = build(:voucher, unit: 'rupiah')
      expect(voucher.unit).to eq('rupiah')
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
