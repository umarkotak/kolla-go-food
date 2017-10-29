class LineItem < ApplicationRecord
  belongs_to :food
  belongs_to :cart

  def total_price(ammount, price)
    ammount * price
  end
end