require "rails_helper"

RSpec.describe "discounts index page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Target")
    @merchant2 = Merchant.create!(name: "William-Sonoma")
    @discount1 = @merchant1.discounts.create!(percentage: 15, threshold: 5)
    @discount2 = @merchant1.discounts.create!(percentage: 20, threshold: 10)
    @discount3 = @merchant1.discounts.create!(percentage: 30, threshold: 15)
    @discount4 = @merchant2.discounts.create!(percentage: 10, threshold: 20)
    visit merchant_discounts_path(@merchant1)
  end

  describe "User Story 1" do
    it "shows bulk discounts" do
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
      expect(page).to have_link("Discount ##{@discount1.id}")
      expect(page).to have_link("Discount ##{@discount2.id}")
      expect(page).to have_link("Discount ##{@discount3.id}")
      expect(page).to_not have_link("Discount ##{@discount4.id}")

      click_link("Discount ##{@discount1.id}")

      expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))
    end
  end

  describe "User Story 2" do
    it "has a link to create a new discount" do
      expect(page).to have_link("Create a New Discount")

      click_link("Create a New Discount")

      expect(current_path).to eq(new_merchant_discount_path(@merchant1))
    end
  end

  describe "User Story 3" do
    it "has a button to delete a discount" do
      within("#discount-#{@discount3.id}") do
        expect(page).to have_button("Delete")
        click_button("Delete")
      end

      expect(current_path).to eq(merchant_discounts_path(@merchant1))
      expect(page).to_not have_link("Discount ##{@discount3.id}")
      expect(page).to_not have_content("#{@discount3.percentage} Percent Off when you buy #{@discount2.threshold} items")
      expect(page).to have_link("Discount ##{@discount1.id}")
      expect(page).to have_link("Discount ##{@discount2.id}")
    end
  end

  describe "holidays" do
    it "has the next three US holidays listed" do
      expect(page).to have_content("Next Three Holidays")
      expect(page).to have_content("Thanksgiving Day")
      expect(page).to have_content("Christmas Day")
      expect(page).to have_content("New Year's Day")
      expect(page).to_not have_content("Martin Luther King, Jr. Day")
      expect(page).to have_content("2023-11-23")
      expect(page).to have_content("2023-12-25")
      expect(page).to have_content("2024-01-01")
    end

    it "can create holiday discounts" do
      within('section', :class => "holiday-Thanksgiving Day") do
        expect(page).to have_button("Create Discount")
        click_button("Create Discount")
      end
      
      expect(current_path).to eq(new_merchant_discount_path(@merchant1))

      fill_in :percentage, with: 50
      fill_in :threshold, with: 25

      click_button

      expect(current_path).to eq(merchant_discounts_path(@merchant1))
      expect(page).to have_content("50 Percent Off when you buy 25 items")
    end
  end
end