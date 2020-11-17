require 'rails_helper'

# バリデーション
RSpec.describe Goal, type: :model do
  before do
    @user = build(:user)
  end

  describe 'バリデーション' do
    it 'ニックネーム、名前、会社名、役職、住まい、電話番号があれば有効であること' do
      expect(@user.valid?).to eq(true)
    end

    it 'ニックネームが空の場合無効であること' do
      @user.nikname = nil
      expect(@user.valid?).to eq(false)
    end

    it '名前が空の場合無効であること' do
      @user.name = nil
      expect(@user.valid?).to eq(false)
    end

    it '会社名が空の場合無効であること' do
      @user.company = nil
      expect(@user.valid?).to eq(false)
    end

    it '役職が空の場合無効であること' do
      @user.position = nil
      expect(@user.valid?).to eq(false)
    end

    it '電話番号が空の場合無効であること' do
      @user.tel = nil
      expect(@user.valid?).to eq(false)
    end

    it '電話番号が重複している場合無効であること' do
      # 入力された電話番号が既に存在する時、登録されない
    end

    it '電話番号が正しくない形式の場合は無効であること' do
    end

    it '住まいに都道府県が含まれていれば有効であること' do
    end

    it 'jobの長さが255以内であれば有効であること' do
    end

    it 'jobの長さが255以上であれば無効であること' do
    end

    it '名前の長さが255以内であれば有効であること' do
    end

    it '名前の長さが255以上であれば無効であること' do
    end

    it 'メールアドレスが正しい形式であれば有効であること' do
    end

    it 'メールアドレスが正しくない形式であれば無効であること' do
    end

    it 'メールアドレスが重複している場合は無効であること' do
    end
  end
end

# クラスメソッド
RSpec.describe user, type: :model do
  before do
    @user = create(:user)
  end

  describe 'クラスメソッド' do
    # 検索機能
    it 'user情報がリストで返ってくること' do
    end
  end
end

# インスタンスメソッド
RSpec.describe user, type: :model do
  before do
    @user = create(:user)
  end

  describe 'インスタンスメソッド' do
    # it 'pointが0かどうか' do
    # end

    # it 'code_error_signupがランダム文字列かどうか' do
    # end
  end
end