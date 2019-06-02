class CreateAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :authors, id: :uuid do |t|
      t.string :firstname
      t.string :lastname
      t.text :bio
      t.string :website

      t.references :user, null: false, foreign_key: true, index: true, type: :uuid

      t.timestamps
    end
  end
end
