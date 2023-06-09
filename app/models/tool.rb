class Tool < ApplicationRecord
  belongs_to :user
  has_many :tool_units, dependent: :destroy, inverse_of: :tool
  accepts_nested_attributes_for :tool_units, allow_destroy: true, reject_if: :all_blank

  validates :store_name, presence: true, length: { maximum: 255 }
  validates :total_unit, presence: true, length: { maximum: 255 },
                         numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  include Calc
  include WinRate
  include SumMedals
  include AverageMedals

  # 台番号のみの配列を返すロジック
  def number_array(tool)
    tool.tool_units.pluck(:number)
  end

  # 台番号の重複を判定してその配列を返すロジック（注意喚起のメッセージ表示はコントローラーに記述）
  def duplication?(tool)
    (return unless number_array(tool).size != number_array(tool).uniq.size)
    number_array(tool).select { |e| number_array(tool).count(e) > 1 }.uniq
  end
end
