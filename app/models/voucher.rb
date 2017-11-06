class Voucher < ApplicationRecord

  validates :kode, :valid_from, :valid_through, :amount, :unit, :max_amount, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validates :unit, inclusion: { in: %w(percent rupiah), message: "%{value} is not a valid unit" }



  before_save :ensure_kode_is_uppercase

  def voucher_value
    if self.unit == 'percent'
      @unit = 'percent'
    elsif self.unit == 'rupiah'
      @unit = 'rupiah'
    end

    @unit
  end

  private
    def ensure_kode_is_uppercase
      self.kode.upcase!
    end

end
