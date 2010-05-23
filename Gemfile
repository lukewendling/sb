source :gemcutter
source "http://gems.github.com"

gem 'rails', '2.3.5'

gem 'javan-whenever', '0.3.7', :require => false
gem 'mislav-will_paginate', '2.3.11', :require => 'will_paginate'
gem 'twitter', '0.6.6'
gem 'lockfile', '1.4.3'
gem 'haml', '2.2.24'
gem 'jeremyevans-exception_notification', '1.0.20090728', :require => 'exception_notification'
gem 'erubis', '2.6.5' # for rails_xss plugin
gem 'cancan', '1.1.1'


group :development do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'ruby-debug'
end

group :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
  gem 'ruby-debug'
  gem 'mocha'
  gem 'thoughtbot-shoulda', :require => 'shoulda'
end

group :production do
  gem 'pg', '0.9.0'
end
