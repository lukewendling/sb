require_dependency File.join(Rails.root, 'lib', 'short_url')

class ShortUrl
  def shorten(long_url, opts={})
    Url.new
  end
  class Url
    def initialize; end
    def short_url
      "http://l.il/b0stoN"
    end
  end
#  class << self
#    def post(url)
#      Rails.logger.debug "rubyurl: #{url}"
#      url
#    end
#  end
end
