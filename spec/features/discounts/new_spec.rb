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

  describe "User Story 2" do
    it "should have a form to make a new discount" do
      visit new_merchant_discount_path(@merchant1)

      fill_in :percentage, with: 23
      fill_in :threshold, with: 25

      #save_and_open_page
      click_button
      expect(current_path).to eq(merchant_discounts_path(@merchant1))
      expect(page).to have_content("23 Percent Off when you buy 25 items")
      expect(page).to have_content("Discount Has Been Created!")
    end

    it "must have valid fields" do
      visit new_merchant_discount_path(@merchant1)

      click_button

      expect(page).to have_content("Percentage can't be blank") 
      expect(page).to have_content("Threshold can't be blank")
    end

    it "must have numbers in fields" do
      visit new_merchant_discount_path(@merchant1)

      fill_in :percentage, with: "cat"
      fill_in :threshold, with: 25
      click_button

      expect(page).to have_content("Error: Percentage is not a number")
    end
    
    it "must have a number between 1 and 100 in percentage" do
      visit new_merchant_discount_path(@merchant1)

      fill_in :percentage, with: 1000
      fill_in :threshold, with: 25
      click_button

      expect(page).to have_content("Error: Percentage is not included in the list")
    end
  end

end