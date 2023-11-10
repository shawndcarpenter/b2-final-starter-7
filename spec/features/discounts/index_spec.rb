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

  describe "User Story 1" do
    it "shows bulk discounts" do
      visit "/merchants/#{@merchant1.id}/discounts"

      within("#discount-#{@discount1.id}") do
        expect(page).to have_link("Discount ##{@discount1.id}")
        expect(page).to have_content("#{@discount1.percentage} Percent Off when you buy #{@discount1.threshold} items")

      end

      within("#discount-#{@discount2.id}") do
        expect(page).to have_link("Discount ##{@discount2.id}")
        expect(page).to have_content("#{@discount2.percentage} Percent Off when you buy #{@discount2.threshold} items")
      end

      within("#discount-#{@discount3.id}") do
        expect(page).to have_link("Discount ##{@discount3.id}")
        expect(page).to have_content("#{@discount3.percentage} Percent Off when you buy #{@discount3.threshold} items")
      end

      expect(page).to_not have_link("Discount ##{@discount4.id}")
    end

    it "links to discount show page" do
      visit "/merchants/#{@merchant1.id}/discounts"

    end
  end

  describe "User Story 2" do
    it "has a link to create a new discount" do
      visit "/merchants/#{@merchant1.id}/discounts"

      expect(page).to have_link("Create a New Discount")

      click_link("Create a New Discount")

      expect(current_path).to eq(new_merchant_discount_path(@merchant1))
    end
  end

  describe "User Story 3" do
    it "has a button to delete a discount" do
      visit "/merchants/#{@merchant1.id}/discounts"

      within("#discount-#{@discount3.id}") do
        expect(page).to have_button("Delete")
        click_button("Delete")
      end

      expect(page).to_not have_link("Discount ##{@discount3.id}")
      expect(page).to_not have_content("#{@discount3.percentage} Percent Off when you buy #{@discount2.threshold} items")
      expect(page).to have_link("Discount ##{@discount1.id}")
      expect(page).to have_link("Discount ##{@discount2.id}")
    end
  end
end