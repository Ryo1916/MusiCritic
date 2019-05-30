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

# css
gem 'bootstrap',           '4.1.3'
gem 'sass-rails',          '5.0.7'
gem 'font-awesome-rails',  '4.7.0.4'
gem 'frontend-generators', '0.2.0'

# js
gem 'jquery-rails',      '4.3.1'
gem 'coffee-rails',      '4.2.2'
gem 'popper_js',         '1.14.3'
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

# API
gem 'rspotify', '2.6.0'

# others
gem 'faker', '1.7.3'


group :development, :test do
  gem 'annotate', '2.7.4'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara',                 '~> 2.13'
  gem 'mysql2',                   '0.4.10'
  gem 'selenium-webdriver',       '3.141.0'
  gem 'rspec-rails',              '3.8.1'
  gem 'rails-controller-testing', '1.0.4'
  gem 'factory_bot_rails',        '4.11.1'
  gem 'shoulda-matchers',         '3.1.2'
  gem 'database_cleaner',         '1.7.0'
  gem 'simplecov',                '0.16.1'
  gem 'test-queue',               '0.4.2'
  gem 'webdrivers',               '3.9.1'
end

group :development do
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  gem 'spring-watcher-listen', '2.0.1'
  gem 'better_errors',         '2.5.0'
  gem 'binding_of_caller',     '0.8.0'
  gem 'pry-byebug',            '3.6.0'
  gem 'pry-rails',             '0.3.9'
  gem 'pry-doc',               '1.0.0'
  gem 'rails-erd',             '1.5.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
