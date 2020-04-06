class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title, limit: 200, null: false
      t.text :body, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
