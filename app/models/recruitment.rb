class Recruitment < ApplicationRecord
  belongs_to :user

  #refile定義
  attachment :store_image
end
