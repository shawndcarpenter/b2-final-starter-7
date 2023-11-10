require "rails_helper"

RSpec.describe "discounts index page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Target")
    @merchant2 = Merchant.create!(name: "William-Sonoma")
    @discount1 = @merchant1.discounts.create!(percentage: 15, threshold: 5)
    @discount2 = @merchant1.discounts.create!(percentage: 20, threshold: 10)
    @discount3 = @merchant1.discounts.create!(percentage: 30, threshold: 15)
    @discount4 = @merchant2.discounts.create!(percentage: 10, threshold: 20)
  end

  describe "User Story 4" do
    it "shows discount's quantity threshold and percentage discount" do
      visit merchant_discount_path(@merchant1, @discount1)

      expect(page).to have_content(@discount1.id)
      expect(page).to have_content("#{@discount1.percentage} Percent Off when you buy #{@discount1.threshold} items")
    end
  end
end