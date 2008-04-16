require 'activerecord'

# CREATE DATABASE db_content_test;
# GRANT ALL PRIVILEGES ON db_content_test.* to 'rails'@'localhost' identified by 'railspass';

RAILS_ENV = 'db_content'

ActiveRecord::Base.configurations = {
  'db_content' => {
    :adapter  => 'mysql',
    :username => 'rails',
    :password => 'railspass',
    :database => 'db_content_test',
  }
}

ActiveRecord::Base.establish_connection 'db_content'
