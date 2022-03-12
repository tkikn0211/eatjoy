class Recruitment < ApplicationRecord
  belongs_to :user
  attachment :store_image
end
