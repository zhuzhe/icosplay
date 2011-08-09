class User < ActiveRecord::Base
  validates_presence_of :name, :pwd, :email, :sex
  validates_confirmation_of :pwd
  validates_inclusion_of :sex, :in => 0..2

  has_one :member
  has_one :album
  has_one :avatar
  belongs_to :community

  has_many :rels, :class_name => 'Rel', :foreign_key => 'master_id'
  has_many :followers, :class_name => 'User', :through => :rels
  has_many :masters, :class_name => 'User', :through => :rels


  FOUNDER = 1

end
