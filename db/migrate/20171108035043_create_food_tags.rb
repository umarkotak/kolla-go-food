class CreateFoodTags < ActiveRecord::Migration[5.1]
  def change
    create_table :food_tags do |t|
      t.belongs_to :food, index: true
      t.belongs_to :tag, index: true
      t.timestamps
    end
  end
end
