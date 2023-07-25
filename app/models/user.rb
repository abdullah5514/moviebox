class User < ApplicationRecord
  has_and_belongs_to_many :role
  has_many :movies
  has_many :comments, dependent: :destroy
  has_one :reviews, dependent: :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_picture
  
  def admin?
    role.where(role_type: 'admin').present?
  end 
end
