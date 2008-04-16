require 'activerecord'
require 'rake'

module ActiveRecord
  module ConnectionAdapters
    class AbstractAdapter
      def dump_content_to(*args)
        raise "not supported by this database adapter"
      end
      
      def load_content_from(*args)
        raise "not supported by this database adapter"
      end
    end
    
    class MysqlAdapter < AbstractAdapter
      def dump_content_to(fname)
        sh dump_content_to_cmd(fname)
      end
      
      def load_content_from(fname)
        sh load_content_from_cmd(fname)
      end
      
      private
      def dump_content_to_cmd(fname)
        zipper = '| gzip' if fname =~ /\.gz$/
        "mysqldump --add-drop-table --add-locks -K -e #{mysql_params} #{zipper} > #{fname}"
      end
      
      def load_content_from_cmd(fname)
        if fname =~ /\.gz$/
          "gunzip < #{fname} | mysql #{mysql_params}"
        else
          "mysql #{mysql_params} < #{fname}"
        end
      end
      
      def mysql_params
        config = ActiveRecord::Base.configurations[RAILS_ENV]
        options = {
          :host => "-h",
          :username => "-u",
          :password => "-p",
          :database => nil
        }.map { |key, option|
          value = config[key] || config[key.to_s]
          "#{option}#{value}" if value
        }.join(' ')
      end
    end
  end
end
