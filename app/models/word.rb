class Word < ActiveRecord::Base
  attr_accessible :definition, :high_frequency, :images, :lemma, :wordnet_id

  validates :lemma, uniqueness: true
  validates_presence_of :lemma, :definition, :wordnet_id

  serialize :images, Array

  default_scope order("lemma ASC")

  scope :with_images, where("images IS NOT NULL")
  scope :high_frequency, where(high_frequency: true)

  has_many :day_words


  def synsets
    @synsets ||= wordnet_word.synsets  
  end

  def wordnet_word
    @wordnet_word ||= WordNet::Word.find(wordid: wordnet_id)
  end

  def self.random_high_frequency
    self.unscoped.high_frequency.random
  end

  def fetch_images
    fetched_images = GoogleImage.search(lemma)
    update_attributes(images: fetched_images) unless fetched_images.empty?
  rescue
    Rails.logger.error("Error while fething images for #{lemma}")
  end

  # return the word for the current day if exists
  # else assign a new word for the day
  def self.of_the_day
    number_for_the_day = Date.today.to_s.gsub(/\D/, "").to_i
    word_of_the_day = DayWord.where(day: number_for_the_day).first.try(:word)
    unless word_of_the_day
      word_of_the_day = self.unscoped.high_frequency.includes(:day_words).where("day_words.id IS NULL").sample
      word_of_the_day.day_words.create(day: number_for_the_day)
    end
    word_of_the_day
  end
end
