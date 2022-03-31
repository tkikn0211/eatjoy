class Recruitment < ApplicationRecord
 
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :title, presence: true, length: { maximum: 15 }
  validates :body, presence: true, length: { maximum: 100 }
  validates :store_name, presence: true, length: { maximum: 15 }
  validates :store_address, presence: true, length: { maximum: 50 }
  validates :genre, presence: true, length: { maximum: 15 }

  attachment :store_image

  # 検索方法分岐
  def self.looks(search, word)
    if search == "partial"
      @recruitment = Recruitment.where(["title like? OR genre like?", "%#{word}%", "%#{word}%"])
    elsif search == "perfect"
      @recruitment = Recruitment.where(["title like? OR genre like?", "#{word}", "#{word}"])
    else
      @recruitment = Recruitment.all
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #通知機能いいね
  def create_notification_favorite!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and recruitment_id = ? and action = ? ", current_user.id, user_id, id, "favorite"])
    if temp.blank?
      notification = current_user.active_notifications.new(
        recruitment_id: id,
        visited_id: user_id,
        action: "favorite"
      )
      #自分の投稿には通知済み
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end



end
