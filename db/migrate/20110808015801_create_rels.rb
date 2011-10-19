class CreateRels < ActiveRecord::Migration
  def self.up
    create_table :rels do |t|
      t.integer :master_id
      t.integer :follower_id
      t.integer :status

      t.timestamps
    end
  end

  def self.down
    drop_table :rels
  end
end
