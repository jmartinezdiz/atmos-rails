class CreateCountry < ActiveRecord::Migration[8.1]

  def change
    create_table :countries do |t|
      t.string :alpha3_code, limit: 3
      t.string :name_en
      t.string :name_es
      t.timestamps
    end
  end

end
