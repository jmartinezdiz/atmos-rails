class CountriesController < ApplicationController

  def show
    @country = Country.find(params[:id])
  end

  def show_political_division
    @country = Country.find(params[:id])
    @country_political_division = @country.country_political_divisions.find(params[:political_division_id])
    @start_date = (Date.parse(params[:start_date]) rescue nil || Date.today.beginning_of_week)
  end

end
