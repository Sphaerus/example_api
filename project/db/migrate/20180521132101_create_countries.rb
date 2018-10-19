# frozen_string_literal: true

class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :code, null: false
      t.references :panel_provider, null: false, foreign_key: true

      t.timestamps
    end

    add_index(:countries, :code, unique: true)
  end
end
