class ShortUrl
  include HTTParty
  
  class << self
    def post_with_rubyurl(url)
      response = post_without_rubyurl('http://rubyurl.com/api/links',  :body => {:link => {:website_url => url}})
      response['link']['permalink']
      
      rescue
        url
    end
    
    alias_method_chain :post, :rubyurl
  end
end
