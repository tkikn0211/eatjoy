class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :user_image
  
  #アソシエーション
  has_many :recruitments, dependent: :destroy 
  has_many :user_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
  
end
