p "Populating db with high frequency words from dictionary.com"

words = JSON File.read("#{Rails.root}/lib/gre.json")
total = 0
words.each do |word|
  wordnet_id = WordNet::Word.find(lemma: word["word"].downcase).try(:wordid)
  if wordnet_id
    word = Word.find_or_create_by_lemma(lemma: word["word"].downcase, definition: word["definition"], wordnet_id: wordnet_id, high_frequency: true)
    word.update_images
    word.update_synonyms
    count += 1
    p "#{word["word"]} added with wordnet_id:#{wordnet_id}"
  end
end

p "#{count} words added to the db"
