# frozen_string_literal: true
require "rails_helper"

RSpec.describe Recruitment, type: :model do

  describe "投稿のテスト" do
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

  describe "バリデーションのテスト" do
    before do
      @recruitment = FactoryBot.build(:recruitment)
    end

    context "タイトルが存在しない場合" do
      it "無効な状態であること" do
        @recruitment.title = ""
        @recruitment.valid?
        expect(@recruitment.errors[:title]).to include("を入力してください")
      end
    end

    context "タイトルが15文字を超える場合" do
      it "エラーメッセージが出ること" do
        @recruitment.title = "a" * 16
        @recruitment.valid?
        expect(@recruitment.errors[:title]).to include("は15文字以内で入力してください")
      end
    end

    context "店舗名が存在しない場合" do
      it "無効な状態であること" do
        @recruitment.store_name = ""
        @recruitment.valid?
        expect(@recruitment.errors[:store_name]).to include("を入力してください")
      end
    end

    context "店舗名が15文字を超える場合" do
      it "エラーメッセージが出ること" do
        @recruitment.store_name = "a" * 16
        @recruitment.valid?
        expect(@recruitment.errors[:store_name]).to include("は15文字以内で入力してください")
      end
    end

    context "店舗住所が存在しない場合" do
      it "無効な状態であること" do
        @recruitment.store_address = ""
        @recruitment.valid?
        expect(@recruitment.errors[:store_address]).to include("を入力してください")
      end
    end

    context "店舗住所が50文字を超える場合" do
      it "エラーメッセージが出ること" do
        @recruitment.store_address = "a" * 51
        @recruitment.valid?
        expect(@recruitment.errors[:store_address]).to include("は50文字以内で入力してください")
      end
    end

    context "ジャンルが存在しない場合" do
      it "無効な状態であること" do
        @recruitment.genre = ""
        @recruitment.valid?
        expect(@recruitment.errors[:genre]).to include("を入力してください")
      end
    end

    context "ジャンルが15文字を超える場合" do
      it "エラーメッセージが出ること" do
        @recruitment.genre = "a" * 16
        @recruitment.valid?
        expect(@recruitment.errors[:genre]).to include("は15文字以内で入力してください")
      end
    end

    context "コメントが存在しない場合" do
      it "無効な状態であること" do
        @recruitment.body = ""
        @recruitment.valid?
        expect(@recruitment.errors[:body]).to include("を入力してください")
      end
    end

    context "コメントが100文字を超える場合" do
      it "エラーメッセージが出ること" do
        @recruitment.body = "a" * 101
        @recruitment.valid?
        expect(@recruitment.errors[:body]).to include("は100文字以内で入力してください")
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