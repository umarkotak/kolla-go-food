class AdminController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  # GET /admins
  # GET /admins.json
  def index
    if params[:submit].present?
      case params[:submit]
      when 'food'
        params[:minimum_price] == '' ? minimum_price = 0 : minimum_price = params[:minimum_price]
        params[:maximum_price] == '' ? maximum_price = Food.maximum(:price) : maximum_price = params[:maximum_price]

        @foods = Food.search(params[:food_name], params[:description], minimum_price, maximum_price)
      when 'order'
        params[:minimum_total_price] == '' ? minimum_price = 0 : minimum_price = params[:minimum_total_price]
        params[:maximum_total_price] == '' ? maximum_price = Order.maximum(:total) : maximum_price = params[:maximum_total_price]

        @orders = Order.search(params[:order_name], params[:address], params[:email], params[:payment_type], minimum_price, maximum_price)
      when 'restaurant'
        params[:minimum_food_count] == '' ? minimum_food_count = 0 : minimum_food_count = params[:minimum_food_count] 
        params[:maximum_food_count] == '' ? maximum_food_count = Food.all.count : maximum_food_count = params[:maximum_food_count]
        @restaurants = Restaurant.search(params[:restaurant_name], params[:restaurant_address], minimum_food_count, maximum_food_count)
      end
    else

    end
    
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params.require(:admin).permit(:food_name, :description, :minimum_price, :maximum_price, :order_name, :address, :email, :payment_type, :minimum_total_price, :maximum_total_price, :restaurant_name, :restaurant_address, :minimum_food_count, :maximum_food_count, :submit)
    end
end
