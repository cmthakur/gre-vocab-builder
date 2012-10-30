$dictionary = if Rails.env.production?
  WordNet::Lexicon.new(ENV['DATABASE_URL'])
else
  WordNet::Lexicon.new
end