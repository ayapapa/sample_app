source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

gem 'rails', '6.1.3.1' #'~> 6.1.3', '>= 6.1.3.1'

gem 'bootstrap-sass', '3.4.1'
gem 'puma', '5.2.2' #'~> 5.0'
gem 'sass-rails', '6.0.0' #'>= 6'
gem 'webpacker', '5.3.0' #'~> 5.0'
gem 'turbolinks', '5.2.1' #'~> 5'
gem 'jbuilder', '2.11.2' #'~> 2.7'

#gem 'bcrypt', '~> 3.1.7'

# gem 'image_processing', '~> 1.2'

gem 'bootsnap', '1.7.4' #'>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'sqlite3', '1.4.2' #'~> 1.4'
  gem 'byebug', '11.1.3', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '4.1.0' #'>= 4.1.0'

  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'rack-mini-profiler', '2.3.1' #'~> 2.0'
  gem 'listen', '3.5.1' #'~> 3.3'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', '2.1.1'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '3.35.3' #'>= 3.26'
  gem 'selenium-webdriver', '3.142.7'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers', '4.6.0'

  gem 'minitest',                 '5.14.4'
  gem 'minitest-reporters',       '1.4.3'
  gem 'guard',                    '2.16.2'
  gem 'guard-minitest',           '2.4.6'
end

group :production do
  gem 'pg', '1.2.3' #'0.20.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '2.0.4', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
