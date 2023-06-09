require 'rails_helper'

RSpec.describe Tool do
  describe 'バリデーションの確認' do
    it '正常に登録されること' do
      tool = create(:tool)
      tool.valid?
      expect(tool).to be_valid
    end

    it '店舗名が未入力の場合、エラーが出ること' do
      tool = build(:tool, store_name: '')
      tool.valid?
      expect(tool.errors[:store_name]).to include('を入力してください')
    end

    it 'パチスロ総設置台数が未入力の場合、エラーが出ること' do
      tool = build(:tool, total_unit: '')
      tool.valid?
      expect(tool.errors[:total_unit]).to include('を入力してください')
    end

    it '店舗名が255文字以上の場合、エラーが出ること' do
      tool = build(:tool, store_name: ('a' * 256).to_s)
      tool.valid?
      expect(tool.errors[:store_name]).to include('は255文字以内で入力してください')
    end

    it 'パチスロ総設置台数が255文字以上の場合、エラーが出ること' do
      tool = build(:tool, total_unit: ('1' * 256).to_i)
      tool.valid?
      expect(tool.errors[:total_unit]).to include('は255文字以内で入力してください')
    end

    it 'パチスロ総設置台数が数値ではない場合、エラーが出ること' do
      tool = build(:tool, total_unit: 'a')
      tool.valid?
      expect(tool.errors[:total_unit]).to include('は数値で入力してください')
    end

    it 'パチスロ総設置台数が正の整数ではない場合、エラーが出ること' do
      tool = build(:tool, total_unit: '-1'.to_i)
      tool.valid?
      expect(tool.errors[:total_unit]).to include('は0以上の値にしてください')
    end
  end
end
