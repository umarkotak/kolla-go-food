class Tag < ApplicationRecord
  has_many :food_tags
  has_many :foods, through: :food_tags

  before_destroy :ensure_not_referenced_by_any_food

  validates :name, presence: true, uniqueness: true

  private

  def ensure_not_referenced_by_any_food
    unless foods.empty?
      errors.add(:base, 'Foods present')
      throw :abort
    end 
  end
end
