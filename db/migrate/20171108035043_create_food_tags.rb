class CreateFoodTags < ActiveRecord::Migration[5.1]
  def change
    create_table :food_tags do |t|

      t.timestamps
    end
  end
end
