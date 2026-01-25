class CreateTemperaturesForecast < ActiveRecord::Migration[8.1]

  def change
    create_table :temperatures_forecasts do |t|
      t.references :country_political_division, foreign_key: true
      t.date :date
      t.string :measurement_unit
      t.decimal :max_value, precision: 15, scale: 2
      t.decimal :min_value, precision: 15, scale: 2
      t.timestamps
    end
  end

end
