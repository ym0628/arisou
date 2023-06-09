class ToolUnit < ApplicationRecord
  belongs_to :tool, inverse_of: :tool_units, touch: true

  validates :number, presence: true, length: { maximum: 255 }, numericality: { greater_than_or_equal_to: 0 }
  validates :medal, presence: true, length: { maximum: 255 }
end
