class Discount < ApplicationRecord
  validates :percentage, presence: true
  validates :threshold, presence: true

  belongs_to :merchant
end