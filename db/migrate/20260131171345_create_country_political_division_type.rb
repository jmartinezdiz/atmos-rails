class CreateCountryPoliticalDivisionType < ActiveRecord::Migration[8.1]

  def change
    create_table :country_political_division_types do |t|
      t.references :country, foreign_key: true
      t.references :higher_country_political_division_type, foreign_key: { to_table: :country_political_division_types }
      t.string :name_en
      t.string :name_es
      t.timestamps
    end
  end

end
