class StoreController < ApplicationController
  def index
    @foods = params[:letter].nil? ? Food.all.order(:name) : Food.by_letter(params[:letter]).order(:name)
    # order({name: :asc})
    # order({name: :desc})

  end
end
