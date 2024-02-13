class AddNameAndProfileToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :profile, :text
  end
end
