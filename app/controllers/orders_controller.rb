class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  def index
    # @orders = Order.all
    # @orders = Order.by_letter(params[:letter])
    @orders = params[:letter].nil? ? Order.all : Order.by_letter(params[:letter])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_params
      params.require(:order).permit(:name, :description, :image_url, :price, :category, :category_id)
    end
end
