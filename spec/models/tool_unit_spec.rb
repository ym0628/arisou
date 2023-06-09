require 'rails_helper'

RSpec.describe ToolUnit do
  describe 'バリデーションの確認' do
    it '台番と差枚数も含めたツール出力結果が正常に登録される' do
      tool = create(:tool)
      tool.valid?
      expect(tool).to be_valid
    end

    it '台番が未入力の場合、エラーが出ること' do
      tool_unit = build(:tool_unit, number: '', medal: '1')
      tool_unit.valid?
      expect(tool_unit.errors[:number]).to include('を入力してください')
    end

    it '差枚が未入力の場合、エラーが出ること' do
      tool_unit = build(:tool_unit, number: '1', medal: '')
      tool_unit.valid?
      expect(tool_unit.errors[:medal]).to include('を入力してください')
    end

    it '台番が255文字以上の場合、エラーが出ること' do
      tool_unit = build(:tool_unit, number: ('1' * 256).to_i)
      tool_unit.valid?
      expect(tool_unit.errors[:number]).to include('は255文字以内で入力してください')
    end

    it '差枚が255文字以上の場合、エラーが出ること' do
      tool_unit = build(:tool_unit, medal: ('1' * 256).to_i)
      tool_unit.valid?
      expect(tool_unit.errors[:medal]).to include('は255文字以内で入力してください')
    end

    it '台番が正の整数ではない場合、エラーが出ること' do
      tool_unit = build(:tool_unit, number: '-1', medal: '1')
      tool_unit.valid?
      expect(tool_unit.errors[:number]).to include('は0以上の値にしてください')
    end
  end
end
