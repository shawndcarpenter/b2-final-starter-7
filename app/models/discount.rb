class Discount < ApplicationRecord
  validates :percentage, presence: true, numericality: true, inclusion: { in: 1..100 }
  validates :threshold, presence: true, numericality: true
  belongs_to :merchant

  # US 6
  def percent_multiplied
    (100 - percentage) * 0.01
  end
end