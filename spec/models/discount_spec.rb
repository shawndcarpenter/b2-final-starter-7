require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe "validations" do
    it { should validate_presence_of :percentage }
    it { should validate_presence_of :threshold }
    it { should validate_numericality_of(:percentage) }
    it { should validate_numericality_of(:threshold) }
    it { should validate_inclusion_of(:percentage).in_range(1..100) }
  end
  
  describe "relationships" do
    it { should belong_to :merchant }
    it should { have_many(:invoice_items).through(:merchant) }
  end

  before :each do
    @merchant1 = Merchant.create!(name: "Target")
    @merchant2 = Merchant.create!(name: "William-Sonoma")
    @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
    @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)
    @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
    @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
    @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 1, unit_price: 10, status: 1)
    @discount1 = @merchant1.discounts.create!(percentage: 15, threshold: 5)
    @discount5 = @merchant1.discounts.create!(percentage: 20, threshold: 5)
    @discount6 = @merchant1.discounts.create!(percentage: 25, threshold: 5)
    @discount7 = @merchant1.discounts.create!(percentage: 30, threshold: 5)
    @discount2 = @merchant1.discounts.create!(percentage: 20, threshold: 10)
    @discount3 = @merchant1.discounts.create!(percentage: 30, threshold: 15)
    @discount4 = @merchant2.discounts.create!(percentage: 10, threshold: 20)
  end

  describe "percent_multiplied" do
    it "should give the amount multiply the revenue by" do
      expect(@discount1.percent_multiplied).to eq(0.85)
    end
  end
end