# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.string :external_id, null: false
      t.string :secret_code, null: false

      t.timestamps
    end

    add_index(:locations, :external_id, unique: true)
  end
end
