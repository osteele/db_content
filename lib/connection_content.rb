require 'activerecord'

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
    
    class AbstractAdapter
      def dump_content_to(fname)
        zipper = '| gzip' if fname =~ /\.gz$/
        sh "mysqldump --add-drop-table --add-locks -K -e #{mysql_params} #{zipper} > #{fname}"
      end
      
      def load_content_from(fname)
        if fname =~ /\.gz$/
          sh "gunzip < #{fname} | mysql #{mysql_params}"
        else
          sh "mysql #{mysql_params} < #{fname}"
        end
      end
      
      private
      def mysql_params
        config = ActiveRecord::Base.configurations[RAILS_ENV]
        raise "mysql adapter required" unless config['adapter'] == 'mysql'
        options = {
          :host => "-h",
          :username => "-u",
          :password => "-p",
          :database => nil
        }.map { |key, option|
          value = config[key.to_s]
          "#{option}#{value}" if value
        }.join(' ')
      end
    end
  end
end
