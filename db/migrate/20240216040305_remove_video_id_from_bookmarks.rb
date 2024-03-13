class RemoveVideoIdFromBookmarks < ActiveRecord::Migration[7.1]
  if column_exists?(:bookmarks, :video_id)
    def change
    remove_column :bookmarks, :video_id, :string
    end
  end
end
