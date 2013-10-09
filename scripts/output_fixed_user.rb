# coding: utf-8

require File.expand_path( './../lib/loader.rb' )

PACKED_USERS_FILE = 'users.msgpack'
users = Lib::Loader.new( PACKED_USERS_FILE ).unpack

OSAKA = 0
TOKYO = 1
UNKNOWN = -1

users.each do |raw|
  user_id, location_id = raw[0].to_i, raw[1].to_i
  unless location_id == UNKNOWN
    puts "#{user_id},#{location_id}"
  end
end

