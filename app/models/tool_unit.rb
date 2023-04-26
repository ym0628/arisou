class ToolUnit < ApplicationRecord
  belongs_to :tool, inverse_of: :tool_units

  validates :number, presence: true, length: { maximum: 255 }
  validates :medal, length: { maximum: 255 }
end
