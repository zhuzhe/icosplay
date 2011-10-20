class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :content
      t.integer :from
      t.integer :to

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
