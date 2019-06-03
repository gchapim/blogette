# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts, id: :uuid do |t|
      t.string :title
      t.text :subtitle
      t.references :author, null: false, foreign_key: true, index: true, type: :uuid
      t.text :content

      t.string :slug
      t.boolean :active

      t.datetime :published_at
      t.timestamps
    end
  end
end
