require "rails_helper"

RSpec.describe "holidays index" do
  it "should display upcoming holidays" do
    visit "/holidays"

    expect(page).to have_content("All Upcoming Holidays")
  end
end