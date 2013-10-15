# coding: utf-8

require 'csv'

UNKNOWN = -1
DEFAULT_UNKNOWN = 14572 # 66
CORRECT_CSV = File.expand_path( "./../../data/fixed_user.csv" )
File.expand_path( "./../66_result.csv" )

def store_into_hash( csv )
  hash = {}
  CSV.foreach( csv ) do |raw|
    user_id, location_id = raw[0], raw[1]
    hash.store( user_id, location_id )
  end
  hash
end

correct = store_into_hash( CORRECT_CSV )
target  = store_into_hash( TARGET_CSV  )

# precision

precision_result = []

correct.each do |user_id, location_id|
  target_location = target[user_id]
  location_id == target_location ? precision_result << true : precision_result << false
end

correct_count = precision_result.count { |result| result == true }
precision_score = correct_count.to_f / precision_result.size.to_f

puts "Precision: #{precision_score}"

# recall

unknown_count = DEFAULT_UNKNOWN - target.count { |user_id, location_id| location_id.to_i == UNKNOWN }
recall_score = unknown_count.to_f / DEFAULT_UNKNOWN.to_f

puts "Recall: #{recall_score}"

# F-measure

f_measure = 2 * precision_score * recall_score / ( precision_score + recall_score )
puts "F-Measure: #{f_measure}"
