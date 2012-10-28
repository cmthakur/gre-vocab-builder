class GoogleImage


  def self.search(keyword)
    response = HTTParty.get("http://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=#{keyword}")
    response["responseData"]["results"].map{|h| h["unescapedUrl"]}
  end



end