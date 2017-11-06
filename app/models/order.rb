class Order < ApplicationRecord
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

  def total_price_reduce
    
  end
end
