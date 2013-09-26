# coding: utf-8

require File.expand_path( './../lib/data_initializer.rb' )

USERS_FILE = { csv: 'users.csv', output: 'users.msgpack' }
GRAPH_FILE = { csv: 'graph.csv', output: 'graph.msgpack' }

FILES = [
  USERS_FILE,
  GRAPH_FILE,
]

FILES.each do |file|
  initializer = Lib::DataInitializer.new( file[:csv], file[:output] )
  initializer.pack
end
