class CreateUsersTags < ActiveRecord::Migration
  def self.up
    create_table :users_tags, :id => false do |t|
      t.integer :user_id
      t.integer :tag_id
    end
  end

  def self.down
    drop_table :users_tags
  end
end
