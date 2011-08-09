class CreateFans < ActiveRecord::Migration
  def self.up
    create_table :fans do |t|
      t.integer :master_id
      t.integer :fan_id
      t.integer :status

      t.timestamps
    end
  end

  def self.down
    drop_table :fans
  end
end
