class CreateCategoriesPosts < ActiveRecord::Migration[6.0]
  def change
    create_table :categories_posts, id: false do |t|
      t.belongs_to :category, null: false, foreign_key: true, index: true, type: :uuid
      t.belongs_to :post, null: false, foreign_key: true, index: true, type: :uuid
    end
  end
end
