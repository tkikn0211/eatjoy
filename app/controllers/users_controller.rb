class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit, :destroy, :show, :favorites ]
  before_action :authenticate_user!, except: [:index]
  #いいね一覧
  before_action :set_user, only: [:favorites]

  def index
    redirect_back(fallback_location: root_path)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @user = current_user
    redirect_to user_path(current_user) unless current_user == @user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  #退会機能
  def unsubscribe
    @user = User.find_by(account_name: params[:account_name])
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  #いいね一覧
  def favorites
    favorites = Favorite.where(user_id: @user.id).pluck(:recruitment_id)
    @recruitments = Recruitment.find(favorites)

  end

  #DM一覧
  def rooms
    @rooms = current_user.rooms
  end


 private
  #いいね一覧
  def set_user
    @user = User.find(params[:id])
  end


  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :address, :email, :account_name, :user_image, :hobby, :body)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
