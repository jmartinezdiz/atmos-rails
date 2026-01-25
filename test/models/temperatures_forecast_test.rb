require "test_helper"

class TemperaturesForecastTest < ActiveSupport::TestCase

  def setup
    @forecast = temperatures_forecasts(:one)
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
    duplicate_forecast.measurement_unit = "F"
    assert duplicate_forecast.valid?
  end

  test "max_value should be greater or equal to min_value" do
    @forecast.max_value = 10
    @forecast.min_value = 20
    assert_not @forecast.valid?
    assert_includes @forecast.errors[:max_value], I18n.t("errors.messages.greater_than_or_equal_to", count: @forecast.min_value)
    @forecast.max_value = 20
    @forecast.min_value = 20
    assert @forecast.valid?
  end

  test "values should be within range" do
    @forecast.max_value = 10_000_000_000_000
    assert_not @forecast.valid?
    @forecast.max_value = 25
    @forecast.min_value = -10_000_000_000_000
    assert_not @forecast.valid?
  end

end
