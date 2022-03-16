class FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @recruitment = Recruitment.find(params[:recruitment_id])
    favorite = current_user.favorites.new(recruitment_id: @recruitment.id)
    favorite.save
  end

  def destroy
    @recruitment = Recruitment.find(params[:recruitment_id])
    favorite = current_user.favorites.find_by(recruitment_id: @recruitment.id)
    favorite.destroy
  end
end
