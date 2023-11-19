class Recipe < ApplicationRecord
    belongs_to :user

    private

  def convert_times_to_seconds
    self.preparation_time = convert_string_to_time(preparation_time)
    self.cooking_time = convert_string_to_time(cooking_time)
  end

  def convert_string_to_time(time_string)
    hours, minutes, seconds = time_string.split(':').map(&:to_i)
    hours.hours + minutes.minutes + seconds.seconds
  end
end
