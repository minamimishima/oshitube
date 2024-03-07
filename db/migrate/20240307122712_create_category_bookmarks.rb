class CreateCategoryBookmarks < ActiveRecord::Migration[7.1]
  def change
    create_table :category_bookmarks do |t|
      t.references :category, null: false, foreign_key: true
      t.references :bookmark, null: false, foreign_key: true

      t.timestamps
    end
  end
end
