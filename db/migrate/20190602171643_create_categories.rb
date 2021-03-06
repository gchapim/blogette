# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories, id: :uuid do |t|
      t.string :name
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end
