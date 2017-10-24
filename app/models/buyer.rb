class Buyer < ApplicationRecord
  validates :name, :email, :phone, :address, presence: true
  validates :phone, numericality: true, length: { is: 12 }
  # validates :name, uniqueness: true
  validates :email, format: {
    with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  }
end
