module CountriesHelper

  def country_political_division_breadcrumb(country_political_division)
    breadcum = [
      link_to(country_political_division.country.name, country_path(country_political_division.country)),
      *country_political_division.higher_country_political_divisions.reverse.map do |x|
        link_to(x.name, political_division_country_path(country_political_division.country, political_division_id: x))
      end,
      link_to(country_political_division.name, political_division_country_path(country_political_division.country, political_division_id: country_political_division))
    ]
    breadcum.join(" / ").html_safe
  end

end
