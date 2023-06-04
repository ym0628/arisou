require "rails_helper"

RSpec.describe UserMailer do
  # pending "add some examples to (or delete) #{__FILE__}"
  describe 'パスワードリセットのメール送信の検証' do
    let(:user) { create(:user) }
    let(:mail) { UserMailer.reset_password_email(user) }

    before do
      user.generate_reset_password_token!
      mail.deliver_now
    end

    context 'メールを送信した時' do
      it 'ヘッダー情報,ボディ情報が正しいこと' do
        expect(mail.subject).to eq 'パスワードリセット'
        expect(mail.to).to eq [user.email]
        expect(mail.from) == ENV['SENDER_ADDRESS']
      end

      it 'メール本文が正しいこと' do
        expect(mail.html_part.body.to_s).to match("#{user.first_name} #{user.last_name}様")
        expect(mail.html_part.body.to_s).to match('パスワード再発行のご依頼を受け付けました。')
        expect(mail.html_part.body.to_s).to match('こちらのリンクからパスワードの再発行を行ってください。')
        expect(mail.html_part.body.to_s).to match("http://localhost:3000/password_resets/#{user.reset_password_token}/edit")
        expect(mail.text_part.body.to_s).to match("#{user.first_name} #{user.last_name}様")
        expect(mail.text_part.body.to_s).to match('パスワード再発行のご依頼を受け付けました。')
        expect(mail.text_part.body.to_s).to match('こちらのリンクからパスワードの再発行を行ってください。')
        expect(mail.text_part.body.to_s).to match("http://localhost:3000/password_resets/#{user.reset_password_token}/edit")
      end
    end
  end
end
