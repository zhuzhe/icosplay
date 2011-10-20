class CreatePoint < ActiveRecord::Migration
  def self.up
    create_table :points do |t|
      t.integer :user_id
      t.integer :photo_id

      t.timestamps
    end
  end

  def self.down
    drop_table :points
  end
end
