require "rails_helper"

RSpec.describe "Userモデルのテスト", type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe "バリデーションのテスト" do
    it "姓、名、カナ姓、カナ名、メール、住所、パスワードがあれば有効な状態であること" do
      expect(@user).to be_valid
    end

    it "姓がなければ無効な状態である" do
      @user.last_name = ''
      @user.valid?
      expect(@user.errors[:last_name]).to include("を入力してください")
    end

    it "性が10文字以下でなければ無効である" do
      @user.last_name = "a" * 11
      @user.valid?
      expect(@user.errors[:last_name]).to include("は10文字以内で入力してください")
    end

    it "名が10文字以下でなければ無効であること" do
      @user.first_name = "a" * 11
      @user.valid?
      expect(@user.errors[:first_name]).to include("は10文字以内で入力してください")
    end

    it "カナ姓がなければ無効な状態であること" do
      @user.last_name_kana = ""
      @user.valid?
      expect(@user.errors[:last_name_kana]).to include("を入力してください")
    end

    it "カナ姓が10文字以下でなければ無効であること" do
      @user.last_name_kana = "a" * 11
      @user.valid?
      expect(@user.errors[:last_name_kana]).to include("は10文字以内で入力してください")
    end

    it "カナ名がなければ無効な状態であること" do
      @user.first_name_kana = ""
      @user.valid?
      expect(@user.errors[:first_name_kana]).to include("を入力してください")
    end

    it "カナ名が10文字以下でなければ無効であること" do
      @user.first_name_kana = "a" * 11
      @user.valid?
      expect(@user.errors[:first_name_kana]).to include("は10文字以内で入力してください")
    end

    it "メールがなければ無効である" do
      @user.email = ""
      @user.valid?
      expect(@user.errors[:email]).to include("を入力してください")
    end

    it "重複したメールアドレスなら無効な状態であること" do
      User.create(
        email: "user1@user.com",
        password: "user1pass",
      )
      user = User.new(
        email: "user1@user.com",
        password: "user2pass",
      )
      user.valid?
    end

    it "住所がなければ無効な状態であること" do
      @user.address = ""
      @user.valid?
      expect(@user.errors[:address]).to include("を入力してください")
    end

    it "住所が10文字以下でなければ無効な状態であること" do
      @user.address = "a" * 11
      @user.valid?
      expect(@user.errors[:address]).to include("は10文字以内で入力してください")
    end


  end

  describe "アソシエーションのテスト" do
    context "Recruitmentモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:recruitments).macro).to eq :has_many
      end
    end
    context "messageモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:messages).macro).to eq :has_many
      end
    end
    context "favoritモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context "user_roomモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:user_rooms).macro).to eq :has_many
      end
    end
    context "roomモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:rooms).macro).to eq :has_many
      end
    end
    context "active_notificationモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
    end
    context "passive_notificationモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
    end
  end

end