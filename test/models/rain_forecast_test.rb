require "test_helper"

class RainForecastTest < ActiveSupport::TestCase

  def setup
    @forecast = rain_forecasts(:one)
  end

  test "should be valid" do
    assert @forecast.valid?
  end

  test "date should be unique per division and unit" do
    duplicate_forecast = @forecast.dup
    assert_not duplicate_forecast.valid?
    duplicate_forecast.date = @forecast.date + 10.days
    assert duplicate_forecast.valid?
    duplicate_forecast.date = @forecast.date
    duplicate_forecast.measurement_unit = "L/m2"
    assert duplicate_forecast.valid?
  end

  test "value should be within range" do
    @forecast.value = 10_000_000_000_000
    assert_not @forecast.valid?
    @forecast.value = -10_000_000_000_000
    assert_not @forecast.valid?
  end

end
