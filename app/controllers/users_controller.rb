class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
     @user = User.find(params[:id])
  end

  def edit
    @user = current_user
    redirect_to user_path(current_user) unless current_user == @user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :show
    end
  end

   private

  def user_params
    params.require(:user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :address, :email, :account_name, :user_image_id, :hobby, :body)
  end

end
