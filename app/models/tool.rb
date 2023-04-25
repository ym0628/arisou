class Tool < ApplicationRecord
  belongs_to :user
  has_many :tool_units, dependent: :destroy, inverse_of: :tool
  accepts_nested_attributes_for :tool_units, allow_destroy: true, reject_if: :all_blank

  validates :store_name, presence: true, length: { maximum: 255 }
  validates :total_unit, presence: true, length: { maximum: 255 }
end
