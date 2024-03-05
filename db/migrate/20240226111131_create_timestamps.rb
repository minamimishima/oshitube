class CreateTimestamps < ActiveRecord::Migration[7.1]
  def change
    create_table :timestamps do |t|
      t.integer :bookmark_id
      t.integer :hour
      t.integer :minute
      t.integer :second
      t.integer :start_time
      t.string :comment

      t.timestamps
    end
  end
end
