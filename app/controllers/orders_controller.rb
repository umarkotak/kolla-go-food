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

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }

        # Cart.destroy(session[:cart_id])
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }

        @orders = Order.order(:name)
        ActionCable.server.broadcast 'orders', html: render_to_string('store/index', layout: false)
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    def check_cart
      if @cart.line_items.empty?
        redirect_to store_index_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :payment_type)
    end
end
