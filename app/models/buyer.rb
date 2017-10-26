class Buyer < ApplicationRecord
  validates :name, :email, :phone, :address, presence: true
  validates :phone, numericality: true, length: { is: 12, message: "must be 12 characters"}
  # validates :name, uniqueness: true
  validates :email, format: {
    with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
    message: "your email format is wrong"
  }

  def self.by_letter(letter)
    where("name LIKE ?", "#{letter}%").order(:name)
  end
end
