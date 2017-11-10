class Order < ApplicationRecord

  attr_accessor :voucher_kode

  has_many :line_items, dependent: :destroy
  belongs_to :voucher, optional: true

  enum payment_type: {
    "Cash" => 0,
    "Go Pay" => 1,
    "Credit Card" => 2
  }

  validates :name, :address, :email, :payment_type, presence: true
  validates :email, format: {
    with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
    message: "your email format is wrong"
  }

  validates :payment_type, inclusion: payment_types.keys

  def add_line_items(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      item.order_id = id
      line_items << item
    end
  end

  def total_price
    total = 0
    line_items.each do |item|
      total += item.total_price
    end
    total
  end

  def total_discount
    total = 0
    if voucher.nil? == false
      if voucher.unit == 'percent'
        total = total_price * voucher.amount / 100
      elsif voucher.unit == 'rupiah'
        total = voucher.amount
      end      

      total = voucher.max_amount if total > voucher.max_amount
    end    
    total
  end

  def total_payment
    total = total_price - total_discount
    total < 0 ? total = 0 : total
  end

  def find_voucher
    voucher_id = Voucher.find_by(kode: voucher_kode)
    voucher_id.nil? ? nil : voucher_id.id
  end

  def self.search(name, address, email, minimum_price, maximum_price)
    foods = Food.where("name LIKE ? AND description LIKE ? AND price >= ? AND price <= ?", "%#{name}%", "%#{description}%", minimum_price, maximum_price).order(:name)
    foods
  end
end
