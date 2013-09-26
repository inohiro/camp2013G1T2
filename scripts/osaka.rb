# coding: utf-8

require File.expand_path( './../lib/loader.rb' )

PACKED_USERS_FILE = 'users.msgpack'
PACKED_GRAPH_FILE = 'graph.msgpack'

graph = Lib::Loader.new( PACKED_GRAPH_FILE ).unpack
users = Lib::Loader.new( PACKED_USERS_FILE ).unpack

OSAKA = 0
TOKYO = 1
UNKNOWN = -1

osaka_ids = []
osaka = {}
dict = {}

users.each do |raw|
  user_id,location_id = raw[0].to_i,raw[1].to_i
  dict.store( user_id, location_id )
  # osaka.store( user_id, [] ) if location_id == OSAKA
  osaka.store( user_id, [] ) if location_id == TOKYO
end

graph.each do |raw|
  src,dst = raw[0].to_i,raw[1].to_i

  ### if src.location == OSAKA then store
  # osaka[src] << dst if osaka.key? src
  if osaka.key? src
    location_id = dict[dst]
    osaka[src] << location_id
  end
end

# dst にしかなっていないユーザーがいる？

puts "ID\tTOKYO\tOSAKA\tUNKNOWN"
osaka.each do |src,dst_location_ids|
  total = dst_location_ids.size
  unless total == 0
    total = total.to_f
    tokyo = dst_location_ids.count { |e| e == TOKYO } / total
    osaka = dst_location_ids.count { |e| e == OSAKA } / total
    unknown = dst_location_ids.count { |e| e == UNKNOWN } / total
    puts "#{src}\t#{tokyo}\t#{osaka}\t#{unknown}"
  end
end
