class CreateBookmarks < ActiveRecord::Migration[7.1]
  def change
    create_table :bookmarks do |t|
      t.integer :user_id
      t.string :url
      t.text :description
      t.boolean :is_public

      t.timestamps
    end
  end
end
