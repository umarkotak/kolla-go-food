class CreateVouchers < ActiveRecord::Migration[5.1]
  def change
    create_table :vouchers do |t|

      t.timestamps
    end
  end
end
