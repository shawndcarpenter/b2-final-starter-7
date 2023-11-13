class HolidaysController < ApplicationController
  def index 
    response = HTTParty.get("https://date.nager.at/swagger/index.html")
  end
end