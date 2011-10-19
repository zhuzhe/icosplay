class ChangeMessages < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.remove :from
      t.remove :to
      t.integer :from_id
      t.integer :to_id
    end
  end

  def self.down
    change_table :messages do |t|
      t.integer :from
      t.integer :to
      t.remove :from_id
      t.remove :form_id
    end
  end
end
