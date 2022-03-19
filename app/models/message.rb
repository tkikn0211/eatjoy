class Message < ApplicationRecord
  #アソシエーション
  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy
  
  
  #通知機能
  def create_notification_message!(current_user, message_id)
    temp_ids = Message.select(:user_id).where(message_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_message!(current_user, message_id, temp_id["user_id"])
    end
    save_notification_message!(current_user, message_id, user_id) if temp_ids.blank?
  end

  def save_notification_message!(current_user, message_id, visited_id)
    notification = current_user.active_notifications.new(
      message_id: message_id,
      visited_id: visited_id,
      action: "message"
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  
end

