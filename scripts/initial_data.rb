# coding: utf-8

require 'csv'
require 'msgpack'

USERS_FILE = [ File.expand_path( "../data/users.csv" ), 'users' ]
GRAPH_FILE = [ File.expand_path( "../data/graph.csv" ), 'graph' ]

FILES = [
  USERS_FILE,
  GRAPH_FILE,
]

FILES.each do |file|
  array = Array.new
  path,name = file[0],file[1]
  name = File.expand_path( "../data/#{name}.msgpack" )

  CSV.foreach( path ) { |raw| array << raw }
  packed = array.to_msgpack

  File.open( name, 'wb' ) do |file|
    file.write packed
  end
end

