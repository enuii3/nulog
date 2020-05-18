class CreateLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :prefecture_name
      t.string :city_name
      t.string :city_code

      t.timestamps
    end
  end
end
