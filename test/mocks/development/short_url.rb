require_dependency File.join(Rails.root, 'lib', 'short_url')

class ShortUrl
  
  class << self
    def post(url)
      Rails.logger.debug "rubyurl: #{url}"
      url
    end
  end
end
