class CategoryController < ApplicationController
  


  def index
    # @foods = Food.all
    # @foods = Food.by_letter(params[:letter])
    @category = params[:category].nil? ? Food.all : Food.by_category(params[:category])
  end


  def show
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @food = Food.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def food_params
      params.require(:food).permit(:name, :description, :image_url, :price, :category)
    end

end
