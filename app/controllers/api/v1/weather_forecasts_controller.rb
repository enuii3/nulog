require 'uri'
require 'json'

class Api::V1::WeatherForecastsController < ApplicationController
  before_action :change_location, only: :index

  def index
    @tomorrow = Time.current.since(1.day).strftime('%Y-%m-%d')
    @day_after_tomorrow = Time.current.since(2.days).strftime('%Y-%m-%d')
    location = Location.find_by(city_name: @city_name, prefecture_name: @prefecture_name)
    city_code = location[:city_code]

    if find_by_weather_forecasts
    else
      take_weather_forecasts(city_code)
      create_weather_forecast
    end
    render json: @results
  end

  private

  def params_location
    params.permit(:prefecture_name, :city_name)
  end

  def change_location
    if params_location[:city_name]
      @city_name = params_location[:city_name]
      @prefecture_name = params_location[:prefecture_name]

    elsif current_user.city_name
      @city_name = current_user.city_name
      @prefecture_name = current_user.prefecture_name
    else
      render json: nil
    end
  end

  def find_by_weather_forecasts
    @results = WeatherForecast.find_by(
      tomorrow: @tomorrow,
      day_after_tomorrow: @day_after_tomorrow,
      city_name: @city_name,
      prefecture_name: @prefecture_name
    )
  end

  def take_weather_forecasts(code)
    uri = URI.parse("http://weather.livedoor.com/forecast/webservice/json/v1?city=#{code}")
    results_weather_hacks = Net::HTTP.get(uri)
    @results = JSON.parse(results_weather_hacks)
    take_tomorrow_weather_forecasts
    take_day_after_tomorrow_weather_forecasts
  end

  def take_tomorrow_weather_forecasts
    @tomorrow_telop = '-'
    @tomorrow_max_celsius = '-'
    @tomorrow_min_celsius = '-'

    if @results ['forecasts'][1] && @results['forecasts'][1]['temperature']['max']
      @tomorrow_telop = @results['forecasts'][1]['telop'][0]
      @tomorrow_max_celsius = @results['forecasts'][1]['temperature']['max']['celsius']
      @tomorrow_min_celsius = @results['forecasts'][1]['temperature']['min']['celsius']
    elsif @results ['forecasts'][1]
      @tomorrow_telop = @results['forecasts'][1]['telop'][0]
    end
  end

  def take_day_after_tomorrow_weather_forecasts
    @day_after_tomorrow_telop = '-'
    @day_after_tomorrow_max_celsius = '-'
    @day_after_tomorrow_min_celsius = '-'

    if @results['forecasts'][2] && @results['forecasts'][2]['temperature']['max']
      @day_after_tomorrow_telop = @results['forecasts'][2]['telop'][0]
      @day_after_tomorrow_max_celsius = @results['forecasts'][2]['temperature']['max']['celsius']
      @day_after_tomorrow_min_celsius = @results['forecasts'][2]['temperature']['min']['celsius']
    elsif @results['forecasts'][2]
      @day_after_tomorrow_telop = @results['forecasts'][2]['telop'][0]
    end
  end

  def create_weather_forecast
    @results = WeatherForecast.create(
      link: @results['link'],
      prefecture_name: @prefecture_name,
      city_name: @city_name,

      tomorrow: @tomorrow,
      tomorrow_telop: @tomorrow_telop,
      tomorrow_celsius: @tomorrow_max_celsius + '/' + @tomorrow_min_celsius + '℃、',

      day_after_tomorrow: @day_after_tomorrow,
      day_after_tomorrow_telop: @day_after_tomorrow_telop,
      day_after_tomorrow_celsius: @day_after_tomorrow_max_celsius + '/' + @day_after_tomorrow_min_celsius + '℃、'
    )
  end
end
