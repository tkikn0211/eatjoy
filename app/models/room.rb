class Room < ApplicationRecord
  
  has_many :messages
  has_many :user_rooms
  
  #user_roomsを通して２人をusersに格納
  has_many :users,through: :user_rooms
  #roomに入っているusers（２人）をwhere.notで相手の情報をpartnerに格納
  def partner(my_id)
    self.users.where.not(id: my_id)
  end
end