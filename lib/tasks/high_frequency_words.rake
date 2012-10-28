desc "Populate db with high frequency words from dictionary.com"
task :populate_with_high_frequency_words => :environment do
  words = JSON File.read("#{Rails.root}/lib/gre.json")
  words.each do |word|
    wordnet_id = WordNet::Word.find(lemma: word["word"].downcase).try(:wordid)
    Word.find_or_create_by_lemma(lemma: word["word"].downcase, definition: word["definition"], wordnet_id: wordnet_id, high_frequency: true)
    p "#{word["word"]} added with wordnet_id:#{wordnet_id}"
  end
end
