class RemoveVideoIdFromBookmarks < ActiveRecord::Migration[7.1]
  def change
    remove_column :bookmarks, :video_id, :string
  end
end
