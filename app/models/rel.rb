class Rel < ActiveRecord::Base
  validates_presence_of :master_id, :follower_id

  belongs_to :master, :class_name => "User", :foreign_key => "master_id"
  belongs_to :follower, :class_name => "User", :foreign_key => "follower_id"
end
