class AddVideoIdToBookmarks < ActiveRecord::Migration[7.1]
  def change
    add_column :bookmarks, :video_id, :string
  end
end
