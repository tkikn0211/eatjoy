# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Recruitment, "モデルに関するテスト", type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:recruitment)).to be_valid
    end
  end
  context "空白のバリデーションチェック" do
	    it "titleが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
	      recruitment = Recruitment.new(title: '', body:'hoge')
	      expect(recruitment).to be_invalid
	      expect(recruitment.errors[:title]).to include("投稿内容を入力してください。")
	    end
	    it "bodyが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
	      recruitment = Recruitment.new(title: 'hoge', body:'')
	      expect(recruitment).to be_invalid
	      expect(recruitment.errors[:body]).to include("投稿内容を入力してください")
	    end
	  end
end
