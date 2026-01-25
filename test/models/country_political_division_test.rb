require "test_helper"

class CountryPoliticalDivisionTest < ActiveSupport::TestCase
  def setup
    @comunidad = country_political_divisions(:madrid_comunidad)
    @provincia = country_political_divisions(:madrid_provincia)
  end

  test "should be valid" do
    assert @comunidad.valid?
    assert @provincia.valid?
  end

  test "should set country from type before validation" do
    @comunidad.country = nil
    @comunidad.valid?
    assert_equal countries(:spain), @comunidad.country
  end

  test "should validate consistency of country relations" do
    @provincia.higher_country_political_division = country_political_divisions(:madrid_comunidad)
    french_type = country_political_division_types(:spain_comunidad).dup
    french_type.country = countries(:france)
    french_type.name_en = "French Region"
    french_type.save!(validate: false)
    french_div = CountryPoliticalDivision.new(
      country: countries(:france),
      country_political_division_type: french_type,
      name_en: "Normandy",
      name_es: "Normandía",
      code: "NOR"
    )
    french_div.save!
    @provincia.higher_country_political_division = french_div
    assert_not @provincia.valid?
    assert_includes @provincia.errors[:base], I18n.t("activerecord.errors.models.country_political_division.attributes.base.country_relations_not_match")
  end

  test "should validate consistency of hierarchy types" do
    other_provincia = @provincia.dup
    other_provincia.code = "OTH"
    other_provincia.name_en = "Other"
    other_provincia.save!
    @provincia.higher_country_political_division = other_provincia
    assert_not @provincia.valid?
    assert_includes @provincia.errors[:base], I18n.t("activerecord.errors.models.country_political_division.attributes.base.higher_country_political_division_type_relations_not_match")
  end

  test "add_lower_political_division! should create a child division" do
    new_child = @comunidad.add_lower_political_division!(code: "NEW", name_en: "New Province", name_es: "Nueva Provincia")
    assert new_child.persisted?
    assert_equal @comunidad, new_child.higher_country_political_division
    assert_equal country_political_division_types(:spain_provincia), new_child.country_political_division_type
    assert_equal countries(:spain), new_child.country
  end

  test "higher_country_political_divisions returns ancestors in order" do
    municipio = country_political_divisions(:madrid_capital)
    ancestors = municipio.higher_country_political_divisions
    assert_equal 2, ancestors.size
    assert_equal country_political_divisions(:madrid_provincia), ancestors[0]
    assert_equal country_political_divisions(:madrid_comunidad), ancestors[1]
  end

end
