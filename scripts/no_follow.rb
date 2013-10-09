# coding: utf-8

require File.expand_path( './../lib/loader.rb' )

hash = Hash.new
inv_hash = Hash.new

PACKED_GRAPH_FILE = 'graph.msgpack'
graph = Lib::Loader.new( PACKED_GRAPH_FILE ).unpack

graph.each do |raw|
  src,dst = raw[0],raw[1]
  if hash.key? src
    hash[src] << dst.to_i
  else
    hash.store( src, [ dst.to_i ] )
  end

  if inv_hash.key? dst
    inv_hash[dst] << src.to_i
  else
    inv_hash.store( dst, [src.to_i] )
  end
end

src_size = hash.keys.size
num_of_dests = hash.map { |k,v| v.size }
avg = num_of_dests.inject(:+) / num_of_dests.size

max = num_of_dests.max
min = num_of_dests.min

inverted_hash = hash.invert

puts '============================================'
puts src_size
puts avg
puts max
puts min

dst_size = inv_hash.keys.size
num_of_srcs = inv_hash.map{ |k,v| v.size }
inv_avg = num_of_srcs.inject(:+) / num_of_srcs.size
inv_max = num_of_srcs.max
inv_min = num_of_srcs.min

puts "--------------------------------------------"
puts dst_size
puts inv_avg
puts inv_max
puts inv_min

