class Restaurant < ApplicationRecord
  has_many :foods
  has_many :reviews, as: :reviewable

  before_destroy :ensure_not_referenced_by_any_food

  validates :name, presence: true, uniqueness: true
  validates :address, presence: true

  def self.search(name, address, min_count, max_count)
    foods = Food.joins(:restaurant)
    restaurants = Restaurant.where("name LIKE ?", "%#{name}%").where("address LIKE ?", "%#{address}%")
    # foods = foods.select("restaurants.id, COUNT(foods.id) as counter").group("restaurants.id")

    foods = foods.group("restaurants.id").count
    foods = foods.select { |k ,v| v > min_count.to_i && v < max_count.to_i }

    # foods = foods.where("counter >= ? AND counter <= ?", min_count, max_count)
    # foods = foods.pluck("restaurants.id")
    begin
      restaurants = restaurants.find(foods.keys)
    rescue
    end

    # restaurants = foods
    restaurants
  end

  private

  def ensure_not_referenced_by_any_food
    unless foods.empty?
      errors.add(:base, 'Foods present')
      throw :abort
    end 
  end
end
