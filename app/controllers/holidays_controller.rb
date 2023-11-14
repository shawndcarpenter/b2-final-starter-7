class HolidaysController < ApplicationController
  def index 
    @holidays = HolidayService.get_holidays.first(3)
  end
end