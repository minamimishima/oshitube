class ChangeIsPublicDefaultToBookmarks < ActiveRecord::Migration[7.1]
  def change
    change_column_default :bookmarks, :is_public, from: nil, to: false
  end
end
