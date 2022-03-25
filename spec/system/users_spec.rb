require 'rails_helper'

RSpec.describe "Users", type: :system do
  let(:user){FactoryBot.create(:user)}
  describe 'ユーザー認証のテスト' do
    describe 'ユーザー新規登録' do
      before do
        visit new_user_registration_path # 新規登録画面へ遷移
      end
      context '新規登録画面に遷移' do
        it '新規登録に成功する' do
          # fill_in で登録情報をテキストボックスへ入力
          fill_in '名前(姓)', with: "テスト"
          fill_in '名前(名)', with: "テスト"
          fill_in 'フリガナ(セイ)', with: "テスト"
          fill_in 'フリガナ(メイ)', with: "テスト"
          fill_in "アカウント名", with: "test"
          fill_in 'メールアドレス', with: "test@example.com"
          fill_in '住所', with: "東京都"
          fill_in 'パスワード', with: "test1234"
          fill_in '確認用パスワード', with: "test1234"
          click_button '新規登録' 
          expect(page).to have_content 'アカウント登録が完了しました。'
        end
        
         it '新規登録に失敗する' do
          fill_in '名前(姓)', with: ""
          fill_in '名前(名)', with: ""
          fill_in 'フリガナ(セイ)', with: ""
          fill_in 'フリガナ(メイ)', with: ""
          fill_in "アカウント名", with: ""
          fill_in 'メールアドレス', with: ""
          fill_in '住所', with: ""
          fill_in 'パスワード', with: ""
          fill_in '確認用パスワード', with: ""
          click_button '新規登録' 
          expect(page).to have_conte "は保存されませんんでした。"
      end
    end
  end
end
