require "rails_helper"

RSpec.describe "merchant discount show page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Target")
    @merchant2 = Merchant.create!(name: "William-Sonoma")
    @discount1 = @merchant1.discounts.create!(percentage: 15, threshold: 5)
    @discount2 = @merchant1.discounts.create!(percentage: 20, threshold: 10)
    @discount3 = @merchant1.discounts.create!(percentage: 30, threshold: 15)
    @discount4 = @merchant2.discounts.create!(percentage: 10, threshold: 20)
  end

  describe "User Story 5" do
    it "allows editing" do
      visit edit_merchant_discount_path(@merchant1, @discount1)

      # expect(page).to have_content(15)
      # expect(page).to have_content(5)
      expect(find_field("Percentage").value).to eq("#{@discount1.percentage}")
      expect(find_field("Threshold").value).to eq("#{@discount1.threshold}")

      fill_in "Percentage", with: "23"
      click_button
      
      expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))
      expect(page).to have_content("23 Percent Off when you buy 5 items")
      expect(page).to_not have_content("15 Percent Off when you buy 5 items")
    end
  end
end