class User < ActiveRecord::Base
  validates_presence_of :name, :pwd, :email, :sex
  validates_confirmation_of :pwd
  validates_inclusion_of :sex, :in => 0..2

  has_one :member
  has_one :album
  has_one :avatar
  belongs_to :community
  belongs_to :city

  has_many :rels, :class_name => 'Rel', :foreign_key => 'master_id'
  has_many :followers, :class_name => 'User', :through => :rels
  has_many :masters, :class_name => 'User', :through => :rels
  has_and_belongs_to_many :tags, :join_table => 'users_tags'


  FOUNDER = 1

  MALE = 0
  FEMALE = 1

  def age
     Time.now.year - self.birthday.year
  end

  def sex_text
    case self.sex
      when MALE then '男'
      when FEMALE then '女'
    end
  end

end
