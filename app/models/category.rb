class Category < ApplicationRecord
  has_many :food, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def self.by_category(category)
    where("category LIKE ?", "#{category}").order(:name)
  end

end
