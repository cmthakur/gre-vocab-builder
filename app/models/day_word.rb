class DayWord < ActiveRecord::Base
  attr_accessible :day, :word_id

  belongs_to :word
end
