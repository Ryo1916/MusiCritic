source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# basic
gem 'rails',              '5.1.4'
gem 'puma',               '3.9.1'
gem 'uglifier',           '3.2.0'
gem 'haml',               '5.0.4'
gem 'nested_form_fields', '0.8.2'
gem 'turbolinks',         '5.0.1'
gem 'jbuilder',           '2.8.0'
gem 'responders',         '2.4.0'

# db
gem 'mysql2', '0.4.10'

# css
gem 'bootstrap',           '4.1.3'
gem 'sass-rails',          '5.0.7'
gem 'font-awesome-rails',  '4.7.0.4'
gem 'frontend-generators', '0.2.0'

# js
gem 'jquery-rails',      '4.3.1'
gem 'coffee-rails',      '4.2.2'
gem 'popper_js',         '1.14.3'
gem 'coffee-rails',      '4.2.2'
gem 'jquery-turbolinks', '2.1.0'

# images
gem 'carrierwave', '1.2.3'
gem 'mini_magick', '4.9.2'

# authentication
gem 'devise',            '4.5'
gem 'omniauth',          '1.8.1'
gem 'omniauth-facebook', '5.0.0'
gem 'omniauth-twitter',  '1.4.0'
gem 'letter_opener_web', '1.3.4'

# others
gem 'faker',     '1.7.3'
gem 'rails-erd', '1.5.2'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'better_errors',         '2.5.0'
  gem 'binding_of_caller',     '0.8.0'
  gem 'pry-byebug',            '3.6.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
