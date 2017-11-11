class DashboardController < ApplicationController
  def index
    @foods = Food.all
  end
end
