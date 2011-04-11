class ShortUrl
  include HTTParty
  
  base_uri 'http://api.bit.ly/v3/'
  def initialize(login, api_key)
    @default_query_opts = { :login => login, :apiKey => api_key }
  end
 
  def shorten(long_url, opts={})
    query = { :longUrl => long_url }.merge(opts)
    begin
      response = get('/shorten', :query => query)
      url = Url.new(self, response['data'])
      return url.short_url
    rescue
      return long_url
    end
  end
 
  def get(method, opts={})
    opts[:query] ||= {}
    opts[:query].merge!(@default_query_opts)
    response = self.class.get(method, opts)
    if response['status_code'] == 200
      return response
    else
      raise ShortyBeActinCrazyYo, 'Boooyyaaaaaaahhhhhhh'
    end
  end
  
  class ShortyBeActinCrazyYo < StandardError; end
    
  class Url
    attr_reader :short_url, :long_url, :user_hash, :global_hash
  
    def initialize(client, opts={})
      @client = client
      if opts
        @short_url = opts['url']
        @long_url = opts['long_url']
        @user_hash = opts['hash']
        @global_hash = opts['global_hash']
        @new_hash = (opts['new_hash'] == 1)
        @user_clicks = opts['user_clicks']
        @global_clicks = opts['global_clicks']
      end
      @short_url = "http://bit.ly/#{@user_hash}" unless @short_url
    end
  end
end
