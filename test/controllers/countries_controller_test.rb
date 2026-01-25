require "test_helper"

class CountriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @country = countries(:spain)
    @division = country_political_divisions(:madrid_provincia)
  end

  test "should show country" do
    get country_url(@country)
    assert_response :success
    assert_select "h2", text: /#{@country.name}/
    assert_select "a", text: country_political_divisions(:madrid_comunidad).name
  end

  test "should show political division" do
    get political_division_country_url(@country, @division)
    assert_response :success
    assert_select "h2", text: /#{@division.name}/
    assert_select "a", text: country_political_divisions(:madrid_capital).name
    start_date = Date.today.beginning_of_week
    assert_select "a.nav-arrow[href*=?]", (start_date - 7.days).to_s
    assert_select "a.nav-arrow[href*=?]", (start_date + 7.days).to_s
    assert_select "h2", text: I18n.t("views.country_political_divisions.show_forecast.title")
    assert_select ".forecast-value", text: /5.0 mm/
    assert_select ".temperature-max", text: /25.0 C/
    assert_select ".temperature-min", text: /15.0 C/
    assert_select ".forecast-value", text: /15.5 km\/h/
  end

  test "should show political division with start_date param" do
    start_date = Date.today.beginning_of_week + 2.weeks
    get political_division_country_url(@country, @division, start_date: start_date)
    assert_response :success
    assert_select "a.nav-arrow[href*=?]", (start_date - 7.days).to_s
    assert_select "a.nav-arrow[href*=?]", (start_date + 7.days).to_s
  end

end
