class Room < ApplicationRecord
  #アソシエーション
  has_many :messages
  has_many :user_rooms

end
