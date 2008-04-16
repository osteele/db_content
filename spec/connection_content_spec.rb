require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + "/../lib/connection_content")
require 'fileutils'

describe ActiveRecord::ConnectionAdapters::MysqlAdapter do
  before(:each) do
    @connection = ActiveRecord::Base.connection
  end
  
  describe :load_content_from do
    it 'should load from uncompressed file' do
      @connection.load_content_from("#{File.dirname(__FILE__)}/data/content.sql")
    end
    
    it 'should load from compressed file' do
      @connection.load_content_from("#{File.dirname(__FILE__)}/data/content.sql.gz")
    end
  end
  
  describe :dump_content_to do
    before(:each) do
      @tmpdir = File.join(File.dirname(__FILE__), 'tmp')
      FileUtils.mkdir_p @tmpdir
    end
    
    it 'should dump to uncompressed file' do
      pathname = File.join(@tmpdir, 'content.sql')
      @connection.dump_content_to(pathname)
      File.exists?(pathname).should == true
      @connection.load_content_from(pathname)
      FileUtils.rm_r @tmpdir
    end
    
    it 'should dump to compressed file' do
      pathname = File.join(@tmpdir, 'content.sql.gz')
      @connection.dump_content_to(pathname)
      File.exists?(pathname).should == true
      @connection.load_content_from(pathname)
      FileUtils.rm_r @tmpdir
    end
  end
end
