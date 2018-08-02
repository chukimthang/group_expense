source 'https://rubygems.org'

# ruby '2.3.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
gem "figaro"
gem 'kaminari'

group :development, :test do
  gem 'mysql2', '>= 0.3.18', '< 0.5'
  gem 'byebug', platform: :mri
  gem 'rubocop', require: false
  gem 'rails_best_practices'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 3.6'
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
end

group :development do
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'gettext'
  gem 'get_pomo'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'jquery-ui-rails'
gem 'ckeditor'
gem 'devise'
gem 'jQuery-Validation-Engine-rails'
gem 'gettext_i18n_rails'
gem 'wdm', '>= 0.1.0' if Gem.win_platform?
gem 'chosen-rails'
gem 'bootstrap-tagsinput-rails'
gem 'twitter-typeahead-rails'
gem 'momentjs-rails'
gem 'rubyXL', '~> 3.3', '>= 3.3.21'
gem 'cancancan'
# gem 'bcrypt', git: 'https://github.com/codahale/bcrypt-ruby.git', :require => 'bcrypt'
