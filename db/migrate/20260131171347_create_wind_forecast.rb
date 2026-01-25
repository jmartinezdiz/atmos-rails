class CreateWindForecast < ActiveRecord::Migration[8.1]

  def change
    create_table :wind_forecasts do |t|
      t.references :country_political_division, foreign_key: true
      t.date :date
      t.string :measurement_unit
      t.decimal :value, precision: 15, scale: 2
      t.timestamps
    end
  end

end
