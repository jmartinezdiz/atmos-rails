ApplicationRecord.transaction do

  # Data structure

  ## USA
  usa = Country.create!(alpha3_code: "USA", name_en: "United States", name_es: "Estados Unidos")

  state = usa.country_political_division_types.create!(name_en: "State", name_es: "Estado")
  usa_cities = usa.country_political_division_types.create!(name_en: "City", name_es: "Ciudad", higher_country_political_division_type: state)

  california = state.country_political_divisions.create!(code: "CA", name_en: "California", name_es: "California")
  california.reload
  california.add_lower_political_division!(code: "LA", name_en: "Los Angeles", name_es: "Los Ángeles")
  california.add_lower_political_division!(code: "SF", name_en: "San Francisco", name_es: "San Francisco")
  california.add_lower_political_division!(code: "SD", name_en: "San Diego", name_es: "San Diego")

  new_york = state.country_political_divisions.create!(code: "NY", name_en: "New York", name_es: "Nueva York")
  new_york.reload
  new_york.add_lower_political_division!(code: "NYC", name_en: "New York City", name_es: "Nueva York")
  new_york.add_lower_political_division!(code: "BUF", name_en: "Buffalo", name_es: "Búfalo")

  texas = state.country_political_divisions.create!(code: "TX", name_en: "Texas", name_es: "Texas")
  texas.reload
  texas.add_lower_political_division!(code: "HOU", name_en: "Houston", name_es: "Houston")
  texas.add_lower_political_division!(code: "AUS", name_en: "Austin", name_es: "Austin")

  ## Spain
  spain = Country.create!(alpha3_code: "ESP", name_en: "Spain", name_es: "España")

  autonomous_community = spain.country_political_division_types.create!(name_en: "Autonomous Community", name_es: "Comunidad Autónoma")
  cities = spain.country_political_division_types.create!(name_en: "City", name_es: "Ciudad", higher_country_political_division_type: autonomous_community)

  galician = autonomous_community.country_political_divisions.create!(code: "01", name_en: "Galicia", name_es: "Galicia")
  galician.reload
  galician.add_lower_political_division!(code: "01", name_en: "A Coruña", name_es: "A Coruña")
  galician.add_lower_political_division!(code: "02", name_en: "Ferrol", name_es: "Ferrol")
  galician.add_lower_political_division!(code: "03", name_en: "Lugo", name_es: "Lugo")
  galician.add_lower_political_division!(code: "04", name_en: "Ourense", name_es: "Ourense")
  galician.add_lower_political_division!(code: "05", name_en: "Pontevedra", name_es: "Pontevedra")
  galician.add_lower_political_division!(code: "06", name_en: "Santiago de Compostela", name_es: "Santiago de Compostela")
  galician.add_lower_political_division!(code: "07", name_en: "Vigo", name_es: "Vigo")

  asturias = autonomous_community.country_political_divisions.create!(code: "01", name_en: "Asturias", name_es: "Asturias")
  asturias.reload
  asturias.add_lower_political_division!(code: "01", name_en: "Avilés", name_es: "Avilés")
  asturias.add_lower_political_division!(code: "02", name_en: "Gijón", name_es: "Gijón")
  asturias.add_lower_political_division!(code: "03", name_en: "Oviedo", name_es: "Oviedo")
  asturias.add_lower_political_division!(code: "04", name_en: "Siero", name_es: "Siero")

  # Forecast data
  all_divisions = CountryPoliticalDivision.all
  start_date = Date.today.beginning_of_year
  end_date = start_date + 1.year
  current_time = Time.current
  temp_data = []
  rain_data = []
  wind_data = []

  all_divisions.each do |division|
    (start_date..end_date).each do |date|
      # Rain (mm)
      rain_prob = case date.month
      when 10..12, 1..4
        0.6
      else
        0.2
      end
      rain_data << {
        country_political_division_id: division.id,
        date: date,
        value: (rand < rain_prob ? rand(1.0..40.0).round(1) : 0.0),
        measurement_unit: "mm",
        created_at: current_time,
        updated_at: current_time
      }
      # Temperature (°C)
      base_temp = case date.month
      when 12, 1, 2
        rand(5.0..12.0)
      when 3, 4, 11
        rand(10.0..18.0)
      when 5, 6, 9, 10
        rand(15.0..25.0)
      when 7, 8
        rand(20.0..35.0)
      else
        rand(10.0..20.0)
      end
      temp_data << {
        country_political_division_id: division.id,
        date: date,
        min_value: (base_temp - rand(2.0..8.0)).round(1),
        max_value: (base_temp + rand(2.0..8.0)).round(1),
        measurement_unit: "°C",
        created_at: current_time,
        updated_at: current_time
      }
      # Wind (km/h)
      wind_data << {
        country_political_division_id: division.id,
        date: date,
        value: rand(5.0..60.0).round(1),
        measurement_unit: "km/h",
        created_at: current_time,
        updated_at: current_time
      }
    end
  end
  TemperaturesForecast.insert_all(temp_data)
  RainForecast.insert_all(rain_data)
  WindForecast.insert_all(wind_data)

end
