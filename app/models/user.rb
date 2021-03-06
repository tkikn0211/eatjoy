class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :user_image

  has_many :recruitments, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #DM一覧user_rooms通して2人のユーザーをroomsに格納
  has_many :rooms, through: :user_rooms

  #自分からの通知
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  #相手からの
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy


  validates :last_name, presence: true, length: { maximum: 10 }
  validates :first_name, presence: true, length: { maximum: 10 }
  validates :last_name_kana, presence: true, length: { maximum: 10 }
  validates :first_name_kana, presence: true, length: { maximum: 10 }
  validates :account_name, presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 30 }
  validates :address, presence: true, length: { maximum: 10 }


end
