class Users::SessionsController < Devise::SessionsController
  #いいね一覧機能
  before_action :user_state, only: [:create]

  #ゲストログイン
  def new_guest
    user = User.find_or_create_by!(email:'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64 #ランダムのパスワード作成
      #NN制約のためデータを渡す
      user.last_name = "ゲスト"
      user.first_name = "様"
      user.last_name_kana = "ゲスト"
      user.first_name_kana = "サマ"
      user.account_name = "ゲストユーザー"
      user.address = "東京都"
    end
    sign_in user
    flash[:notice] = "ログインに成功しました。"
    redirect_to root_path
  end


  def user_state
    @user = User.find_by(email: params[:user][:email])
    return if !@user
    if @user.valid_password?(params[:user][:password])
      if @user.is_deleted == true
        redirect_to new_user_registration_path
      end
    end
  end

end