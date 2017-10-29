class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.references :food, foreign_key: true
      t.decimal :ammount
      t.timestamps
    end
  end
end
