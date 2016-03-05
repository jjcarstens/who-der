require 'pi_piper'
include PiPiper

TRIGGER_GPIO = 23
ECHO_GPIO = 24

trigger = PiPiper::Pin.new(:pin => 23, :direction => :out)
echo = PiPiper::Pin.new(:pin => 24, :direction => :in)

trigger.on
sleep 0.00001
trigger.off

watch :pin => 23 do
  puts "Pin changed from #{last_value} to #{value}"
end

watch :pin => 24 do
  puts "Pin changed from #{last_value} to #{value}"
end

# after :pin => 24, :goes => :low do
#   @start = Time.now
# end
#
# after :pin => 24, :goes => :high do
#   @stop = Time.now
# end
