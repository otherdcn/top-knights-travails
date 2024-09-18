require_relative "lib/knight"

print "Enter start point (double digits from 0-7 seperated by comma): "
start_coord = gets.chomp.split(",").map(&:to_i)

print "Enter end point (double digits from 0-7 seperated by comma): "
end_coord = gets.chomp.split(",").map(&:to_i)

puts "\nStart at #{start_coord} and end at #{end_coord}\n"

knight = Knight.new

path = knight.knight_moves(start_coord, end_coord)

puts "You made it in #{path.size - 1} moves!  Here's your path: "
path.each do |square|
  print "#{square.data}\n"
end
