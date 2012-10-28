class Word < ActiveRecord::Base
  attr_accessible :definition, :high_frequency, :images, :lemma, :wordnet_id

  validates :lemma, uniqueness: true
  validates_presence_of :lemma, :definition, :wordnet_id

  serialize :images, Array

  default_scope order("lemma ASC")

  scope :with_images, where("images IS NOT NULL")
  scope :high_frequency, where(high_frequency: true)


  def wordnet_word
    WordNet::Word.find(wordid: wordnet_id)
  end
end
