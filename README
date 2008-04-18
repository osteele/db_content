= DB Content Plugin

The DB Content plugin for Rails adds tasks to save and restore
database content.

== Usage

  # dump the development database to db/archive/development-content.sql.gz
  $ rake db:content:dump

  # load the dumped database, and apply any necessary migrations
  $ rake db:content:load

  # dump the production database to db/archive/production-content.sql.gz
  $ RAILS_ENV=production rake db:content:dump

  # save the development database to db/archive/{timestamp}.sql.gz
  $ rake db:content:save

  # save the (compressed) database to my-data.sql.gz
  $ rake db:content:save FILE=my-data.sql.gz

  # save the (uncompressed) database to my-data.sql
  $ rake db:content:save FILE=my-data.sql

  # load the database from my-data.sql
  $ rake db:content:load FILE=my-data.sql

== Tasks

  rake db:content:archive

Saves a timestamped database to db/archive/#{timestamp}.sql.gz

  rake db:content:dump

Dumps the database to FILE or db/#{RAILS_ENV}-content.sql.gz.  If FILE
ends in .gz, the file is compressed.

  rake db:content:load

Loads the database from FILE or db/#{RAILS_ENV}-content.sql.gz, and
migrates it to the current schema version.  If FILE ends in.gz, the
file is piped through gunzip.

== Installation

To install from the top level of a Rails application:
  git clone git://github.com/osteele/db_content.git vendor/plugins/db_content

If you're running off Edge Rails (or, presumably, Rails > 2.0.2), you
should be able to do this instead:
  script/plugin install git://github.com/osteele/db_content

== Limitations

The plugin works only with the MySQL databases. (It adds methods to the Mysql adaptor; see the source.)  The gzip option probably only works on *nix (MacOS, Linux, etc.).

== License

Copyright (c) 2006-2008 by {Oliver Steele}[http://workingwithrails.com/person/12359-oliver-steele].  Released under the MIT license.
