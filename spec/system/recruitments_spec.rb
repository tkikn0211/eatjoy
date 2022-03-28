require 'rails_helper'

RSpec.describe "Recruitments", type: :system do
  let(:user){FactoryBot.create(:user)}
  let!(:recruitment){FactoryBot.create(:recruitment, user: user)}
  before do
    visit new_user_session_path
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
  end

  describe "募集投稿のテスト" do
    describe "ユーザーの新規投稿" do
      before do
        visit new_recruitment_path 
      end
      context "新規投稿画面に遷移" do
        it "新規投稿に成功する" do
          fill_in "recruitment[title]", with: recruitment.title
          fill_in "recruitment[store_name]", with: recruitment.store_name
          fill_in "recruitment[store_address]", with: recruitment.store_address
          fill_in "recruitment[genre]", with: recruitment.genre
          fill_in "recruitment[body]", with: recruitment.body
          click_button "新規投稿"
        end
        
        it "新規投稿に成功する" do
          fill_in "recruitment[title]", with: ""
          fill_in "recruitment[store_name]", with: ""
          fill_in "recruitment[store_address]", with: ""
          fill_in "recruitment[genre]", with: ""
          fill_in "recruitment[body]", with: ""
          click_button "新規投稿"
        end
      end
    end
    
    describe "編集のテスト" do
      context "各画面への遷移の確認" do
        before do
          visit recruitments_path 
        end
        
        it "投稿詳細画面への遷移ができる" do
          click_on "詳細"
        end
        
       
      end
    end
    
    
  end
end
