require 'rails_helper'

RSpec.describe "Users" do
  let(:user) { create(:user) }

  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功する' do
          visit new_user_path
          fill_in '姓', with: 'user'
          fill_in '名', with: 'user'
          fill_in 'メールアドレス', with: 'email@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          expect(page).to have_content 'ユーザー登録が完了しました'
          expect(page).to have_current_path login_path, ignore_query: true
        end
      end

      context '名前が未入力' do
        it 'ユーザーの新規作成が失敗する' do
          visit new_user_path
          fill_in '姓', with: ''
          fill_in '名', with: ''
          fill_in 'メールアドレス', with: 'email@example.com'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          expect(page).to have_content '名を入力してください'
          expect(page).to have_content '姓を入力してください'
          expect(page).to have_current_path users_path, ignore_query: true
        end
      end

      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する' do
          visit new_user_path
          fill_in '姓', with: 'user'
          fill_in '名', with: 'user'
          fill_in 'メールアドレス', with: ''
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          expect(page).to have_content 'メールアドレスを入力してください'
          expect(page).to have_current_path users_path, ignore_query: true
        end
      end

      context '登録済のメールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する' do
          existed_user = create(:user)
          visit new_user_path
          fill_in '姓', with: 'user'
          fill_in '名', with: 'user'
          fill_in 'メールアドレス', with: existed_user.email
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード確認', with: 'password'
          click_button '登録'
          expect(page).to have_content 'メールアドレスはすでに存在します'
          expect(page).to have_current_path users_path, ignore_query: true
          expect(page).to have_field 'メールアドレス', with: existed_user.email
        end
      end

      context 'パスワードが未入力' do
        it 'ユーザーの新規作成が失敗する' do
          visit new_user_path
          fill_in '姓', with: 'user'
          fill_in '名', with: 'user'
          fill_in 'メールアドレス', with: 'email@example.com'
          fill_in 'パスワード', with: ''
          fill_in 'パスワード確認', with: ''
          click_button '登録'
          expect(page).to have_content 'パスワードは3文字以上で入力してください'
          expect(page).to have_content 'パスワード確認を入力してください'
          expect(page).to have_current_path users_path, ignore_query: true
        end
      end
    end
  end
end
