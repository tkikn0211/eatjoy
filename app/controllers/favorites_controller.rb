class FavoritesController < ApplicationController
  
  def create
    @recruitment = Recruitment.find(params[:recruitment_id])
    favorite = current_user.favorites.new(recruitment_id: @recruitment.id)
    favorite.save
    @recruitment.create_notification_favorite!(current_user)
  end

  def destroy
    @recruitment = Recruitment.find(params[:recruitment_id])
    favorite = current_user.favorites.find_by(recruitment_id: @recruitment.id)
    favorite.destroy
  end
end
