require File.join(File.dirname(__FILE__), '../lib/connection_content')

namespace :db do
  namespace :content do
    DEFAULT_DB_DUMP_NAME = File.join(RAILS_ROOT, 'db', 'content.sql.gz')
    
    desc "Dump the database to FILE or #{DEFAULT_DB_DUMP_NAME}"
    task :dump => :environment do
      fname = ENV['FILE'] || DEFAULT_DB_DUMP_NAME
      ActiveRecord::Base.connection.dump_content_to fname
    end

    desc "Load the database from FILE or #{DEFAULT_DB_DUMP_NAME}"
    task :load => :environment do
      fname = ENV['FILE'] || DEFAULT_DB_DUMP_NAME
      ActiveRecord::Base.connection.load_content_from fname
    end
    
    desc "Save a timestamped database to RAILS_ROOT/db/archive"
    task :archive => :environment do
      dir = "#{RAILS_ROOT}/db/archive"
      mkdir_p dir
      n = '0'
      basename = Time.now.strftime('%Y-%m-%d')
      fname = File.join(dir, "#{basename}.sql.gz")
      while File.exists?(fname)
        fname = File.join(dir, "#{basename}-#{n.succ!}.sql.gz")
      end
      ActiveRecord::Base.connection.dump_content_to fname
    end
  end
end
