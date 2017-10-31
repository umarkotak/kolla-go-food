class Category < ApplicationRecord
  has_many :foods
  validates :name, presence: true, uniqueness: true

  before_destroy :ensure_not_referenced_by_any_food

  def self.by_category(category)
    where("category LIKE ?", "#{category}").order(:name)
  end

  private
    def ensure_not_referenced_by_any_food
      unless foods.empty?
        errors.add(:base, 'Foods present')
        throw :abort
      end
    end

end
