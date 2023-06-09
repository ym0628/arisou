require 'rails_helper'

RSpec.describe "Tools" do
  let(:user) { create(:user) }
  let(:tool) { create(:tool) }
  let(:tool_unit) { create(:tool_unit) }
  let(:created_yesterday) { create(:tool, :created_yesterday) }

  describe 'ツール関連' do
    context 'ツール作成' do
      it '未ログイン時はツール新規作成画面にアクセスできないこと' do
        visit new_tool_path
        expect(page).to have_content 'ログインしてください'
        expect(page).to have_current_path login_path
      end

      it 'フォーム入力時に正常に保存・出力に成功すること' do
        login_as(user)
        visit new_tool_path
        fill_in '店舗名', with: 'test'
        fill_in 'パチスロ総設置台数', with: '100'
        fill_in '台番', with: '1'
        fill_in '差枚', with: '1000'
        click_button '出力する'
        expect(page).to have_content 'ツール出力に成功しました'
        expect(Tool.count).to eq 1
        expect(page).to have_current_path '/tools/1'
      end

      it 'フォーム未入力時に、保存・出力に失敗すること' do
        login_as(user)
        visit new_tool_path
        fill_in '店舗名', with: ''
        fill_in 'パチスロ総設置台数', with: ''
        fill_in '台番', with: ''
        fill_in '差枚', with: ''
        click_button '出力する'
        expect(page).to have_content 'ツール出力に失敗しました'
        expect(page).to have_current_path tools_path
      end

      it '台データを複数入力した場合でも問題なく保存・出力されること' do
        login_as(user)
        visit new_tool_path
        fill_in '店舗名', with: 'test'
        fill_in 'パチスロ総設置台数', with: '100'
        fill_in '台番', with: '1'
        fill_in '差枚', with: '1000'
        click_on '入力フォームを追加'
        page.all('.nested-fields')[1].fill_in '台番', with: '2'
        page.all('.nested-fields')[1].fill_in '差枚', with: '1000'
        click_button '出力する'
        expect(page).to have_content 'ツール出力に成功しました'
        expect(Tool.count).to eq 1
        expect(page).to have_current_path '/tools/1'
      end
    end

    context 'ツール詳細' do
      it '入力値が台番号の昇順で表示されること' do
        login_as(user)
        visit new_tool_path
        fill_in '店舗名', with: 'test'
        fill_in 'パチスロ総設置台数', with: '100'
        fill_in '台番', with: '2'
        fill_in '差枚', with: '1000'
        click_on '入力フォームを追加'
        page.all('.nested-fields')[1].fill_in '台番', with: '1'
        page.all('.nested-fields')[1].fill_in '差枚', with: '1000'
        click_button '出力する'
        within ".unit_data" do
          unit_data = all(".unit_data").map(&:text)
          expect(unit_data) == ['台番：1 差枚：1000', '台番：2 差枚：1000']
        end
      end

      it '台番号に重複があった場合にメッセージが表示されること' do
        login_as(user)
        visit new_tool_path
        fill_in '店舗名', with: 'test'
        fill_in 'パチスロ総設置台数', with: '100'
        fill_in '台番', with: '1'
        fill_in '差枚', with: '1000'
        click_on '入力フォームを追加'
        page.all('.nested-fields')[1].fill_in '台番', with: '1'
        page.all('.nested-fields')[1].fill_in '差枚', with: '1000'
        click_button '出力する'
        expect(page).to have_content '台番号 [1] が重複しています。確認してください。'
      end

      it '各末尾の勝率・総差枚数・平均差枚数が正しく算出されていること' do
        login_as(user)
        create(:tool, user:)
        visit '/tools/1'
        within ".result" do
          result = all(".result")
          expect(result) == [
            ['末尾 勝率 末尾別差枚 平均差枚'],
            ['0 20.0%\n(2/10台) 2000 200'],
            ['1 20.0%\n(2/10台) 2000 200'],
            ['2 20.0%\n(2/10台) 2000 200'],
            ['3 20.0%\n(2/10台) 2000 200'],
            ['4 20.0%\n(2/10台) 2000 200'],
            ['5 20.0%\n(2/10台) 2000 200'],
            ['6 20.0%\n(2/10台) 2000 200'],
            ['7 20.0%\n(2/10台) 2000 200'],
            ['8 20.0%\n(2/10台) 2000 200'],
            ['9 20.0%\n(2/10台) 2000 200'],
            ['ゾロ 20.0%\n(2/10台) 2000 200'],
          ]
        end
      end
    end

    context 'ツール編集' do
      it '入力値に変更があった際に、更新日時が最新になっていること' do
        login_as(user)
        create(:tool, :created_yesterday, user:)
        visit '/tools/1/edit'
        click_on '入力フォームを追加'
        page.all('.nested-fields')[20].fill_in '台番', with: '21'
        page.all('.nested-fields')[20].fill_in '差枚', with: '1000'
        click_button '出力する'
        expect(page).to have_content '更新しました'
        expect(page).to have_content "更新日時：#{Time.current.strftime('%Y/%m/%d %H:%M')}"
      end
    end
  end

  describe 'マイページ関連' do
    context 'マイページのアクセス制限（未ログイン時）' do
      it '未ログイン時はマイページへのアクセスに失敗すること' do
        visit tools_path
        expect(page).to have_content 'ログインしてください'
        expect(page).to have_current_path login_path
      end
    end

    context 'マイページのアクセス制限（ログイン後）' do
      it '自分以外のユーザーが作成したツール出力結果が一覧に表示されていないこと' do
        create(:tool)
        login_as(user)
        create(:tool, user:)
        visit tools_path
        expect(page).not_to have_link('store', href: '/tools/1')
        expect(page).to have_link('store', href: '/tools/2')
      end
    end
  end
end
