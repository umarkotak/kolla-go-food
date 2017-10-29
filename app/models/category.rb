class Category < ApplicationRecord
  belongs_to :food

  def self.by_category(category)
    where("category LIKE ?", "#{category}").order(:name)
  end

end
