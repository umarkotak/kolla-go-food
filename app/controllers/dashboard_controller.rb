class DashboardController < ApplicationController
  def index
    @number_of_order_every_date = Order.group(:created_at).count
    @total_price_of_order_every_date = Order.group(:created_at).sum(:total)
    @number_of_order_for_each_food = LineItem.joins(:food).group("foods.name").sum("line_items.quantity")
    @total_price_of_order_for_each_food = LineItem.joins(:food, :order).group("foods.name").sum("foods.price * line_items.quantity")
    @number_of_order_from_each_restaurant = LineItem.joins(:order, food: :restaurant).group("restaurants.name").count("orders.id")
    @total_price_of_order_from_each_restaurant = LineItem.joins(:order, food: :restaurant).group("restaurants.name").sum("foods.price * line_items.quantity")
  end
end
