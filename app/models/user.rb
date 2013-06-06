# == Schema Information
# Schema version: 20100829021049
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable, :confirmable  and :activatable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation

  acts_as_voter
  
  has_many :stories,    :dependent => :destroy
  has_many :comments,    :dependent => :destroy


  def increase_karma
    self.karma += 1
    save
  end

  def decrease_karma
    self.karma += 1
    save
  end
  
  
end
