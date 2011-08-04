class Community < ActiveRecord::Base
  has_many :members
  has_many :users, :order => 'level DESC'

  validates_presence_of :name, :description
end
