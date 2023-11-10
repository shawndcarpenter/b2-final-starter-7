class Discount < ApplicationRecord
  validates :percentage, presence: true, numericality: true
  validates :threshold, presence: true, numericality: true
  belongs_to :merchant

  # US 6
  def percent_multiplied
    (100 - percentage) * 0.01
  end

  def self.best_available_discount(invoice_item)
    Discount.where("threshold <= #{invoice_item.quantity}").order(percentage: :desc).limit(1)
  end
end