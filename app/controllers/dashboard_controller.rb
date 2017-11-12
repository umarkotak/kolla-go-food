class DashboardController < ApplicationController
  def index
    @number_of_order_every_date = Order.group(:created_at).count
    @total_price_of_order_every_date = Order.group(:created_at).sum(:total)
  end
end
