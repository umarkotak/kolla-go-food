class StoreController < ApplicationController
  skip_before_action :authorize
    include CurrentCart
    before_action :set_cart

    # @foods = params[:letter].nil? ? Food.all.order(:name) : Food.by_letter(params[:letter]).order(:name)
    # order({name: :asc})
    # order({name: :desc})
    

    def index
      @foods = Food.order(:name)
    end
end
