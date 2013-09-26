# coding: utf-8

require File.expand_path( './../lib/loader.rb' )

PACKED_USERS_FILE = 'users.msgpack'
users = Lib::Loader.new( PACKED_USERS_FILE ).unpack

hash = Hash.new

users.each do |raw|
  user,location = raw[0],raw[1]
  if hash.key? location
    hash[location] << user.to_i
  else
    hash.store( location, [ user.to_i ] )
  end
end

TOKYO = 1.to_s
OSAKA = 0.to_s
UNKNOWN = -1.to_s

puts hash[OSAKA].size
puts hash[TOKYO].size
puts hash[UNKNOWN].size

# 大阪の人がどれくらい大阪とリンクしているか
# 　　　　　　　　　　東京と
# 東京の人がどれくらい東京とリンクしているか
# 　　　　　　　　　　大阪と
