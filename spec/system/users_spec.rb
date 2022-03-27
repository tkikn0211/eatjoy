require "rails_helper"

RSpec.describe "User", type: :system do
  let(:user){FactoryBot.create(:user)}
  describe "ユーザー認証のテスト" do
    describe "ユーザー新規登録" do
      before do
        visit new_user_registration_path # 新規登録画面へ遷移
      end
      context "新規登録画面に遷移" do
        it "新規登録に成功する" do
          # fill_in で登録情報をテキストボックスへ入力
          fill_in "(姓)", with: "テスト"
          fill_in "(名)", with: "テスト"
          fill_in "(セイ)", with: "テスト"
          fill_in "(メイ)", with: "テスト"
          fill_in "アカウント名", with: "test"
          fill_in "メールアドレス", with: "test@example.com"
          fill_in "住所", with: "東京都"
          fill_in "パスワード", with: "test1234"
          fill_in "確認用パスワード", with: "test1234"
          click_button "新規登録" 
          expect(page).to have_content "アカウント登録が完了しました。"
        end
        
        it '新規登録に失敗する' do
          fill_in "(姓)", with: ""
          fill_in "(名)", with: ""
          fill_in "フリガナ(セイ)", with: ""
          fill_in "フリガナ(メイ)", with: ""
          fill_in "アカウント名", with: ""
          fill_in "メールアドレス", with: ""
          fill_in "住所", with: ""
          fill_in "パスワード", with: ""
          fill_in "確認用パスワード", with: ""
          click_button "新規登録" 
          expect(page).to have_conte "は保存されませんんでした。"
        end
      end
    end
  end
  
  describe "ユーザーログイン" do
    before do
      visit new_user_session_path
    end
      
    ontext "ログイン画面に遷移" do
      it "ログインに成功する" do
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        click_button "ログイン"
        expect(page).to have_content "ログインしました。"
      end
        
      it "ログインに失敗する" do
      　fill_in "メールアドレス", with: ""
        fill_in "パスワード", with: ""
        click_button "ログイン"
        expect(current_path).to eq new_user_session_path
      end
    end
  end
  
  describe "編集のテスト" do
    context "編集画面へ遷移" do
      it "遷移ができる" do
        visit edit_user_path(user)
        expect(current_path).to eq edit_user_path(user)
      end
    end
      
    context "表示の確認と編集" do
      before do
        visit edit_user_path(user)
      end
      
      it "登録情報編集と表示される" do
        expect(page).to have_content('登録情報編集')
      end
      
      it "画像編集フォームが表示される" do
        expect(page).to have_field 'user[user_image]'
      end
      
      it "名前編集フォームに自分の姓が表示される" do
        expect(page).to have_field '(姓)', with: user.last_name
      end
      
      it "名前編集フォームに自分の名が表示される" do
        expect(page).to have_field '(名)', with: user.first_name
      end
      
      it "名前編集フォームに自分のカナ姓が表示される" do
        expect(page).to have_field '(セイ)', with: user.last_name_kana
      end
      
      it "名前編集フォームに自分のカナ名が表示される" do
        expect(page).to have_field '(メイ)', with: user.first_name_kana
      end
      
      it "メールアドレス編集フォームに自分のメールアドレスが表示される" do
        expect(page).to have_field 'メールアドレス', with: user.email
      end
      
      it "住所編集フォームに自分の住所が表示される" do
        expect(page).to have_field '住所', with: user.address
      end
      
      it "趣味編集フォームに自分の趣味が表示される" do
        expect(page).to have_field "趣味", with: user.hobby
      end
      
      it "自己紹介編集フォームに自分の自己紹介文が表示される" do
        expect(page).to have_field "自己紹介文", with: user.body
      end
      
      it "編集に成功する" do
        fill_in "(名)", with: "太郎"
        fill_in "(メイ)", with: "タロウ"
        click_button "変更を保存する"
        expect(page).to have_content "会員情報の更新が完了しました。"
        expect(page).to have_content "テスト 太郎 (テスト タロウ)"
        expect(current_path).to eq user_path(user)
      end
      
      it "編集に失敗する" do
        fill_in "名前(名)", with: ""
        click_button "変更を保存する"
        expect(page).to have_content "件のエラーが発生したため ユーザー は保存されませんでした。"
        expect(page).to have_content "名を入力してください"
        expect(current_path).to eq user_path(user)
      end
      
    end
  end
end