source :rubygems
gemspec

gem 'activerecord'

if RUBY_PLATFORM == 'java'
  gem 'activerecord-jdbcsqlite3-adapter'
  gem 'activerecord-jdbcmysql-adapter'
  gem 'activerecord-jdbcpostgresql-adapter'
else
  gem 'sqlite3'
  gem 'mysql2'
  gem 'pg'
end
