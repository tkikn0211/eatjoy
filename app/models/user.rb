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
  has_many :favorites, dependent: :destroy
  
  #自分からの通知
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  #相手からの
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

end
