class Users::SessionsController < Devise::SessionsController
  #ゲストログイン
  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64 #ランダムのパスワード作成
      #NN制約のためデータを渡す
      user.last_name = "ゲスト"
      user.first_name = "様"
      user.last_name_kana = "ゲスト"
      user.first_name_kana = "サマ"
      user.account_name = "ゲストユーザー"
    end
    sign_in user
    redirect_to root_path
  end
  
end