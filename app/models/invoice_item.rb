class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item

  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  # US 6
  def single_revenue
    if !discount_applicable?
      unit_price * quantity
    else
      unit_price * quantity * self.best_available_discount.first.percent_multiplied
    end
  end

  def discount_applicable?
    best_available_discount != []
  end

  def discount_id
    best_available_discount.first.id
  end

  def best_available_discount
    Discount.where("threshold <= #{self.quantity}").order(percentage: :desc).limit(1)
  end
end
