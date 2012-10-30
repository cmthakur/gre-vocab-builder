class Word < ActiveRecord::Base
  attr_accessible :definition, :high_frequency, :images, :lemma, :wordnet_id, :synonyms

  validates :lemma, uniqueness: true
  validates_presence_of :lemma, :definition, :wordnet_id

  serialize :images, Array

  default_scope order("lemma ASC")

  scope :with_images, where("images IS NOT NULL")
  scope :high_frequency, where(high_frequency: true)
  scope :search, ->(search_term){ where("lemma like ? OR synonyms like ? OR definition like ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%") }

  has_many :day_words
  has_many :user_words


  def synsets
    @synsets ||= wordnet_word.synsets  
  end

  def wordnet_word
    @wordnet_word ||= WordNet::Word.find(wordid: wordnet_id)
  end

  def self.random_high_frequency
    self.unscoped.high_frequency.random
  end

  def update_images
    fetched_images = GoogleImage.search(lemma)
    update_attributes(images: fetched_images) unless fetched_images.empty?
  rescue
    Rails.logger.error("Error while fething images for #{lemma}")
  end

  def update_synonyms
    self.update_attributes(synonyms: (synsets.map{|s| s.words.map(&:lemma) }.flatten - [lemma]).join(", "))
  end

  # return the word for the current day if exists
  # else assign a new word for the day
  def self.of_the_day
    day_word_for_today = DayWord.today
    unless day_word_for_today
      random_word = self.unscoped.high_frequency.includes(:day_words).where("day_words.id IS NULL").sample
      day_word_for_today = random_word.day_words.create(day: number_for_the_day)
    end
    return day_word_for_today.word, day_word_for_today
  end


  def next
    self.class.where("lemma > ?", lemma).first
  end

  def previous
    self.class.where("lemma < ?", lemma).last
  end
end
