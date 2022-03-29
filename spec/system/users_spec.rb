require "rails_helper"

RSpec.describe 'User', type: :system do
  let(:user){FactoryBot.create(:user)}

  describe "ユーザー認証のテスト" do
    describe "ユーザー新規登録" do
      before do
        visit new_user_registration_path
      end
      context "新規登録画面に遷移" do
        it "新規登録に成功する" do
          fill_in "user[last_name]", with: user.last_name
          fill_in "user[first_name]", with: user.first_name
          fill_in "user[last_name_kana]", with: user.last_name_kana
          fill_in "user[first_name_kana]", with: user.first_name_kana
          fill_in "user[account_name]", with: user.account_name
          fill_in "user[email]", with: user.email
          fill_in "user[address]", with: user.email
          fill_in "user[password]", with: user.password
          fill_in "user[password]", with: user.password_confirmation
          click_button "新規登録"
        end
        it '新規登録に失敗する' do
          fill_in "(姓)", with: ""
          fill_in "(名)", with: ""
          fill_in "(セイ)", with: ""
          fill_in "(メイ)", with: ""
          fill_in "アカウント名", with: ""
          fill_in "メールアドレス", with: ""
          fill_in "住所", with: ""
          fill_in "user_password", with: ""
          fill_in "user_password", with: ""
          click_button "新規登録"
        end
      end
    end
  end

  describe "ユーザーログイン" do
    before do
      visit new_user_session_path
    end

    context "ログイン画面に遷移" do
      it "ログインに成功する" do
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
        click_button "ログイン"
      end

      it "ログインに失敗する" do
        fill_in "user_email", with: ""
        fill_in "user_password", with: ""
        click_button "ログイン"
      end
    end
  end

end