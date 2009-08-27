raw_config = File.read(Rails.root + 'config' + 'app_config.yml')
AppConfig = YAML.load(raw_config)[Rails.env].symbolize_keys

ConsumerConfig = YAML.load(File.read(Rails.root + 'config' + 'consumer.yml'))

ExceptionNotifier.exception_recipients = %w(debug@shouldbet.com)
ExceptionNotifier.sender_address = %("Application Error" <debug@shouldbet.com>)
ExceptionNotifier.email_prefix = "[Oops] "


