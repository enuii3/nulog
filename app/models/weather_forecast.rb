class WeatherForecast < ApplicationRecord
  validates :prefecture_name, presence: true
  validates :city_name, presence: true
  validates :link, presence: true
  validates :tomorrow, presence: true
  validates :tomorrow_telop, presence: true
  validates :tomorrow_celsius, presence: true
  validates :day_after_tomorrow, presence: true
  validates :day_after_tomorrow_telop, presence: true
  validates :day_after_tomorrow_celsius, presence: true
end
