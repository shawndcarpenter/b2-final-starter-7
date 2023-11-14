class HolidayService
  def self.get_holidays
    response = HTTParty.get("https://date.nager.at/api/v3/NextPublicHolidays/US?limit=3")
    holiday_data = JSON.parse(response.body, symbolize_names: :true)
    
    holiday_data.map do |holiday_hash|
      Holiday.new(holiday_hash)
    end
  end
end