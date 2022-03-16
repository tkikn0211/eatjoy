class Recruitment < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  #refile定義
  attachment :store_image
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "partial"
      @recruitment = Recruitment.where("title LIKE ?","%#{word}%")
    else
      @recruitment = Recruitment.all
    end
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
