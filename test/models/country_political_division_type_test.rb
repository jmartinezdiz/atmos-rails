require "test_helper"

class CountryPoliticalDivisionTypeTest < ActiveSupport::TestCase

  def setup
    @type = country_political_division_types(:spain_comunidad)
    @sub_type = country_political_division_types(:spain_provincia)
  end

  test "should be valid" do
    assert @type.valid?
    assert @sub_type.valid?
  end

  test "name_en should be unique per country" do
    duplicate_type = @type.dup
    assert_not duplicate_type.valid?
    duplicate_type.country = countries(:france)
    assert duplicate_type.valid?
  end

  test "higher_country_political_division_type should be unique per country" do
    duplicate_sub_type = @sub_type.dup
    duplicate_sub_type.name_en = "Another Province"
    duplicate_sub_type.name_es = "Otra Provincia"
    assert_not duplicate_sub_type.valid?
  end

  test "should validate consistency of country relations" do
    @sub_type.higher_country_political_division_type = country_political_division_types(:spain_comunidad)
    @sub_type.country = countries(:france)
    assert_not @sub_type.valid?
    assert_includes @sub_type.errors[:base], I18n.t("activerecord.errors.models.country_political_division_type.attributes.base.country_relations_not_match")
  end

end
