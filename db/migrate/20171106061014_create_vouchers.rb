class CreateVouchers < ActiveRecord::Migration[5.1]
  def change
    create_table :vouchers do |t|
      t.string :kode
      t.date :valid_from
      t.date :valid_through
      t.string :unit
      t.float :amount
      t.float :max_amount 

      t.timestamps
    end
  end
end
