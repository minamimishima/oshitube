class AddVideoTitleToBookmarks < ActiveRecord::Migration[7.1]
  def change
    add_column :bookmarks, :video_title, :string
  end
end
