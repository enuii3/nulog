class CreateWeatherForecasts < ActiveRecord::Migration[6.0]
  def change
    create_table :weather_forecasts do |t|
      t.string :link, null: false
      t.string :prefecture_name, null: false
      t.string :city_name, null: false
      t.string :tomorrow, null: false
      t.string :tomorrow_telop, null: false
      t.string :tomorrow_celsius, null: false
      t.string :day_after_tomorrow, null: false
      t.string :day_after_tomorrow_telop, null: false
      t.string :day_after_tomorrow_celsius, null: false

      t.timestamps
    end
  end
end
