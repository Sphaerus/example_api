# frozen_string_literal: true

class CreatePanelProviders < ActiveRecord::Migration[5.2]
  def change
    create_table :panel_providers do |t|
      t.string :code, null: false

      t.timestamps
    end

    add_index(:panel_providers, :code, unique: true)
  end
end
