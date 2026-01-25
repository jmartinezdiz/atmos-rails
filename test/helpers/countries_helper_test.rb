require "test_helper"

class CountriesHelperTest < ActionView::TestCase

  def setup
    @provincia = country_political_divisions(:madrid_provincia)
    @country = @provincia.country
    @comunidad = country_political_divisions(:madrid_comunidad)
  end

  test "country_political_division_breadcrumb generates correct links in order" do
    result = country_political_division_breadcrumb(@provincia)
    assert result.html_safe?
    parts = result.split(" / ")
    assert_equal 3, parts.size
    assert_match @country.name, parts[0]
    assert_match "href=\"/countries/#{@country.id}\"", parts[0]
    assert_match @comunidad.name, parts[1]
    assert_match "href=\"/countries/#{@country.id}/political_divisions/#{@comunidad.id}\"", parts[1]
    assert_match @provincia.name, parts[2]
    assert_match "href=\"/countries/#{@country.id}/political_divisions/#{@provincia.id}\"", parts[2]
  end

end
