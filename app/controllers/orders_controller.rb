class OrdersController < ApplicationController
  include CurrentCart
  before_action :set_cart, only: [:new]
  before_action :check_cart, only: [:new]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    # @orders = Order.all
    # @orders = Order.by_letter(params[:letter])
    @orders = params[:letter].nil? ? Order.all : Order.by_letter(params[:letter])
  end

  def new
    @order = Order.new
    # respond_to()
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def check_cart
      if @cart.line_items.empty?
        redirect_to store_index_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :description, :image_url, :price, :category, :category_id)
    end
end
