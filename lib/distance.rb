require 'pi_piper'
include PiPiper

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
