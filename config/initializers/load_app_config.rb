raw_config = File.read(File.join(Rails.root, 'config', 'app_config.yml'))
AppConfig = YAML.load(raw_config)[Rails.env].symbolize_keys

ConsumerConfig = YAML.load(File.read(File.join(Rails.root, 'config', 'consumer.yml')))

ExceptionNotifier.exception_recipients = %w(debug@shouldbet.com)
ExceptionNotifier.sender_address = %("Application Error" <debug@shouldbet.com>)
ExceptionNotifier.email_prefix = "[Oops] "

INVALID_CONTENT_PATTERN = /<iframe|<script|<frame|\.\.\//i

UrlShortener = ShortUrl.new(AppConfig[:bitly_username], AppConfig[:bitly_key])
