class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :photo_id
      t.integer :user_id
      t.string :content
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
