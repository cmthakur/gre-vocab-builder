class DayWord < ActiveRecord::Base
  attr_accessible :day, :word_id

  belongs_to :word


  def self.today
    DayWord.where(day: date_to_day(Date.today)).first
  end


  def previous_word
    DayWord.where(day: self.class.date_to_day(date.yesterday)).first.try(:word)
  end


  def next_word
    DayWord.where(day: self.class.date_to_day(date.tomorrow)).first.try(:word)
  end


  def date
    Date.parse day.to_s
  end


  def self.date_to_day(date)
    date.to_s.gsub(/\D/, "").to_i
  end
end
