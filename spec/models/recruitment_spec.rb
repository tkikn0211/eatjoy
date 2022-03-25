# frozen_string_literal: true
require "rails_helper"

RSpec.describe Recruitment, type: :model do
  
  describe "バリデーションのテスト" do
    before do
      @recruitment = FactoryBot.build(:recruitment)
      @user = FactoryBot.create(:user)
    end
    
    context "画像以外全てのデータが入っている場合" do
      it "有効な投稿内容の場合は保存されるか" do
        @recruitment.user_id = @user.id
        expect(@recruitment.save).to be true
      end
    end
    
    context "画像以外全てのデータが入っていない場合" do
      it "全て入力されていないので保存されない" do
        @recruitment.user_id = @user.id
        @recruitment.title = ""
        @recruitment.body = ""
        @recruitment.store_name = ""
        @recruitment.store_address = ""
        expect(@recruitment.save).to be false
      end
    end
  end


  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1となっている" do
        expect(Recruitment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context "favoriteモデルとの関係" do
      it "N:1となっている" do
        expect(Recruitment.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context "notificationモデルとの関係" do
      it "N:1となっている" do
        expect(Recruitment.reflect_on_association(:notifications).macro).to eq :has_many
      end
    end
  end
end