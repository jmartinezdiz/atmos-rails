require "test_helper"

class CountryTest < ActiveSupport::TestCase

  def setup
    @country = countries(:spain)
  end

  test "alpha3_code should be at most 3 characters" do
    @country.alpha3_code = "A" * 4
    assert_not @country.valid?
  end

  test "alpha3_code should be unique" do
    duplicate_country = @country.dup
    duplicate_country.name_en = "XYZ"
    duplicate_country.name_es = "XYZ"
    assert_not duplicate_country.valid?
    duplicate_country.alpha3_code = "XYZ"
    assert duplicate_country.valid?
  end

  test "check higher_country_political_division_type" do
    assert_not_nil @country.higher_country_political_division_type
    assert_equal country_political_division_types(:spain_comunidad), @country.higher_country_political_division_type
  end

end
