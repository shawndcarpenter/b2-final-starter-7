require "rails_helper"

RSpec.describe "discounts index page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Target")
    @merchant2 = Merchant.create!(name: "William-Sonoma")
    @discount1 = @merchant1.discounts.create!(percent: 15, quantity: 5)
    @discount2 = @merchant1.discounts.create!(percent: 20, quantity: 10)
    @discount3 = @merchant1.discounts.create!(percent: 30, quantity: 15)
    @discount4 = @merchant2.discounts.create!(percent: 10, quantity: 20)
  end

  describe "User Story 1" do
    it "shows bulk discounts" do
      visit "/merchants/#{@merchant1.id}/discounts"

      expect(page).to have_link("Bulk Discounts")

      click_link("Bulk Discounts")

      expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/")

      within("#discount-#{@discount1.id}") do
        expect(page).to have_link(@discount1.id)
        expect(page).to have_content("#{@discount1.percent} Percent Off when you buy #{@discount1.quantity} items")

      end

      within("#discount-#{@discount2.id}") do
        expect(page).to have_link(@discount2.id)
        expect(page).to have_content("#{@discount2.percent} Percent Off when you buy #{@discount2.quantity} items")
      end

      within("#discount-#{@discount3.id}") do
        expect(page).to have_link(@discount3.id)
        expect(page).to have_content("#{@discount3.percent} Percent Off when you buy #{@discount3.quantity} items")
      end

      expect(page).to_not have_link(@discount4.id)
    end

    it "links to discount show page" do
      visit "/merchants/#{@merchant1.id}/discounts"

    end
  end
end