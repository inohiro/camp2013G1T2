# coding: utf-8

require 'csv'

RAND_MAX = 100
DIVIDER = 3
FIXED_USER_CSV = File.expand_path( '../data/fixed_user.csv' )

CSV.foreach( FIXED_USER_CSV ) do |raw|
  src, dst = raw[0], raw[1]
  rand = Random.rand( RAND_MAX )
  if rand > RAND_MAX / DIVIDER
    puts "#{src},#{-1}"
  else
    puts "#{src},#{dst}"
  end
end
