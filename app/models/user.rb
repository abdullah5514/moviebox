class User < ApplicationRecord
  has_and_belongs_to_many :role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role_type: { admin: 'admin', user: 'user'}
  
  def admin?
    role.where(role_type: 'admin').present?
  end 
end
