class UserWord < ActiveRecord::Base
  attr_accessible :score, :user_id, :word_id

  belongs_to :user
  belongs_to :word
end
