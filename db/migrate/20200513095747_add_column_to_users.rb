class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :prefecture_name, :string
    add_column :users, :city_name, :string
  end
end
