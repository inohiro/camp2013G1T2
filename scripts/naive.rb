# coding: utf-8

require File.expand_path( './../lib/loader.rb' )

PACKED_USERS_FILE = 'users.msgpack'
PACKED_GRAPH_FILE = 'graph.msgpack'

graph = Lib::Loader.new( PACKED_GRAPH_FILE ).unpack
users = Lib::Loader.new( PACKED_USERS_FILE ).unpack

OSAKA = 0
TOKYO = 1
UNKNOWN = -1

dict = {} # user_id -> location_id
user_hash = {} # user_id -> [ following people ]

users.each do |raw|
  user_id, location_id = raw[0].to_i, raw[1].to_i
  dict.store( user_id, location_id )
  user_hash.store( user_id, { osaka: 0, tokyo: 0 } )
end

graph.each do |raw|
  src, dst = raw[0].to_i, raw[1].to_i
  if user_hash.key? src
    location_id = dict[dst]

    if location_id == OSAKA
      user_hash[src][:osaka] += 1
    elsif location_id == TOKYO
      user_hash[src][:tokyo] += 1
    end
  end
end

dict.each do |user_id,location_id|
  if location_id == UNKNOWN
    osaka_count = user_hash[user_id][:osaka]
    tokyo_count = user_hash[user_id][:tokyo]

    if tokyo_count > osaka_count # if tokyo_count >= osaka_count
      dict[user_id] = TOKYO
    else
      dict[user_id] = OSAKA
    end
  end

  puts "#{user_id},#{dict[user_id]}"
end

