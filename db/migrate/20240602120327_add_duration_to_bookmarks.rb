class AddDurationToBookmarks < ActiveRecord::Migration[7.1]
  def change
    add_column :bookmarks, :duration, :integer
  end
end
