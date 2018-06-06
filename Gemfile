source 'https://rubygems.org'

gem 'dotenv'

gem 'sinatra'

gem 'dry-system', git: 'https://github.com/dry-rb/dry-system'
gem 'dry-validation'
gem 'dry-types'
gem 'dry-struct'
gem 'dry-monads', '1.0.0.rc1'

gem 'rom', git: 'https://github.com/rom-rb/rom', branch: 'update-dry-types' do
  gem 'rom-core'
  gem 'rom-mapper'
  gem 'rom-repository'
end

gem 'rom-sql', git: 'https://github.com/rom-rb/rom-sql', branch: 'feature/subqueries'
gem 'pg'
gem 'puma'

group :development, :test do
  gem 'pry-byebug'
end

group :test do
  gem 'rspec'
  gem 'rack-test'
  gem 'warning'
  gem 'rom-factory'
  gem 'faker'
end
