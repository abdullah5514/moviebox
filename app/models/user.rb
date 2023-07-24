class User < ApplicationRecord
  has_and_belongs_to_many :role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum type: { admin: 'admin', user: 'user'}
  
  def admin?
    self&.role&.first&.type == 'admin'
  end 
end
