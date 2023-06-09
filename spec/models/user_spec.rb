require 'rails_helper'

RSpec.describe User do
  describe 'バリデーションの確認' do
    it '正常に登録されること' do
      user = create(:user)
      expect(user).to be_valid
    end

    it '姓が未入力の場合、エラーが出ること' do
      user = build(:user, last_name: '')
      user.valid?
      expect(user.errors[:last_name]).to include('を入力してください')
    end

    it '名が未入力の場合、エラーが出ること' do
      user = build(:user, first_name: '')
      user.valid?
      expect(user.errors[:first_name]).to include('を入力してください')
    end

    it '姓が31字以上の場合、エラーが出ること' do
      user = build(:user, last_name: ('a' * 31).to_s)
      user.valid?
      expect(user.errors[:last_name]).to include('は30文字以内で入力してください')
    end

    it '名が31字以上の場合、エラーが出ること' do
      user = build(:user, first_name: ('a' * 31).to_s)
      user.valid?
      expect(user.errors[:first_name]).to include('は30文字以内で入力してください')
    end

    it 'メールアドレスが未入力の場合、エラーが出ること' do
      user = build(:user, email: '')
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end

    it '登録するメールアドレスが既に存在する場合、エラーが出ること' do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include('はすでに存在します')
    end

    it 'パスワードが3文字未満の場合、エラーが出ること' do
      user = build(:user, password: 'ab')
      user.valid?
      expect(user.errors[:password]).to include('は3文字以上で入力してください')
    end

    it 'パスワードが3文字あれば有効であること' do
      user = build(:user, password: 'abc')
      user.valid?
      expect(user.errors[:password]).not_to include('は3文字以上で入力してください')
    end

    it 'パスワード確認が入力されていない場合、エラーが出ること' do
      user_without_password_confirmation = build(:user, password_confirmation: "")
      expect(user_without_password_confirmation).to be_invalid
      expect(user_without_password_confirmation.errors[:password_confirmation]).to eq %w[とパスワードの入力が一致しません を入力してください]
    end

    it 'パスワード確認がパスワードと異なる場合、エラーが出ること' do
      user_without_password_confirmation = build(:user, password_confirmation: "hogehoge")
      expect(user_without_password_confirmation).to be_invalid
      expect(user_without_password_confirmation.errors[:password_confirmation]).to eq ["とパスワードの入力が一致しません"]
    end
  end
end
