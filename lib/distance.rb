require 'pi_piper'
require 'pry'
include PiPiper

TRIGGER_GPIO = 23
ECHO_GPIO = 24

trigger = PiPiper::Pin.new(:pin => 23, :direction => :out)
echo = PiPiper::Pin.new(:pin => 24, :direction => :in)

trigger.off
echo.off

sleep 1

trigger.on
sleep 0.00001
trigger.off

while echo.off?
  @start = Time.now.to_f
end

while echo.on?
  @stop = Time.now.to_f
end

elapsed = @stop - @start
distance = (elapsed * 34000)/2
puts "Distance: #{distance.round(2)} cm"

#after :pin => 24, :goes => :high do
#  puts "ECHO is high now.."
#end

#after :pin => 24, :goes => :low do
#  puts "ECHO is LOW and SLOW..."
#end

#watch :pin => 24 do |pin|
#  puts "waiting...."
#  puts "Pin changed from #{pin.last_value} to #{pin.value}"
#end
#PiPiper.wait

sleep 2 # Let the GPIO clean up
