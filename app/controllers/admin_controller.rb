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
        params if params[:minimum_price].empty?
        @foods = Food.search(params[:name], params[:description], minimum_price, maximum_price)
      when 'order'
        @orders = Order.all
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
      params.require(:admin).permit(:name, :description, :minimum_price, :maximum_price, :submit)
    end
end
