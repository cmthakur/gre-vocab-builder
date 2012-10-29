class Word < ActiveRecord::Base
  attr_accessible :definition, :high_frequency, :images, :lemma, :wordnet_id

  validates :lemma, uniqueness: true
  validates_presence_of :lemma, :definition, :wordnet_id

  serialize :images, Array

  default_scope order("lemma ASC")

  scope :with_images, where("images IS NOT NULL")
  scope :high_frequency, where(high_frequency: true)


  def synsets
    @synsets ||= wordnet_word.synsets  
  end

  def wordnet_word
    @wordnet_word ||= WordNet::Word.find(wordid: wordnet_id)
  end

  def self.random
    self.unscoped.high_frequency.first(:order => "RANDOM()")
  end

  def fetch_images
    fetched_images = GoogleImage.search(lemma)
    update_attributes(images: fetched_images) unless fetched_images.empty?
  rescue
    Rails.logger.error("Error while fething images for #{lemma}")
  end
end
