class Voucher < ApplicationRecord
  before_destroy :ensure_not_referenced_by_any_order
  before_save :ensure_kode_is_uppercase

  has_many :orders

  validates_uniqueness_of :kode, :case_sensitive => false
  validates :kode, :valid_from, :valid_through, :amount, :unit, :max_amount, presence: true
  validates :amount, :max_amount, numericality: { greater_than: 0 }
  validates :max_amount, numericality: { greater_than_or_equal_to: :amount }
  validates :valid_from, :valid_through, format: {
    with: /[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])/,
    message: 'must be in yyyy-mm-dd format'
  }
  validates :unit, inclusion: { in: %w(percent rupiah), message: "%{value} is not a valid unit" }
  validate :valid_through_must_be_greater_than_valid_from

  # def voucher_value
  #   if self.unit == 'percent'
  #     @unit = 'percent'
  #   elsif self.unit == 'rupiah'
  #     @unit = 'rupiah'
  #   end

  #   @unit
  # end

  validates_each :valid_from do |record, attr, value|
    if !value.nil? && !record.valid_through.nil?
      record.errors.add(attr, "valid_from must be less than valid_through") if value > record.valid_through
    end
  end

  def ensure_kode_is_uppercase
    self.kode.upcase!
  end

  def valid_through_must_be_greater_than_valid_from
    if valid_from.present? && valid_through.present? && valid_through < valid_from
      errors.add(:valid_through, "must be greater than valid_from")
    end
  end

  def ensure_not_referenced_by_any_order
    unless orders.empty?
      errors.add(:base, 'Orders present')
      throw :abort
    end
  end

end
