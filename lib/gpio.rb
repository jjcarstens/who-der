require 'pry'

def pin_path(pin_number)
  "/sys/class/gpio/gpio#{pin_number}"
end

TRIGGER_PIN = 23
ECHO_PIN = 24

begin
still_checking = true

File.open("/sys/class/gpio/export", "w+") { |f| f.write(TRIGGER_PIN) }
File.open("/sys/class/gpio/export", "w+") { |f| f.write(ECHO_PIN) }

TRIGGER_VALUE_PATH = "#{pin_path(TRIGGER_PIN)}/value"
ECHO_VALUE_PATH = "#{pin_path(ECHO_PIN)}/value"

File.open("#{pin_path(TRIGGER_PIN)}/direction", "w+") { |f| f.write("out") }
File.open("#{pin_path(ECHO_PIN)}/direction", "w+") { |f| f.write("in") }

File.write(TRIGGER_VALUE_PATH, "0")

sleep 1.0

File.write(TRIGGER_VALUE_PATH, "1")
sleep 0.00001
File.write(TRIGGER_VALUE_PATH, "0")
@start = Time.now.to_f

while File.read(ECHO_VALUE_PATH).strip == "0"
@start = Time.now.to_f
end

while File.read(ECHO_VALUE_PATH).strip == "1"
@stop = Time.now.to_f
end

#10000.times do
#  if File.read(ECHO_VALUE_PATH).strip == "1"
#    @stop = Time.now
#    puts "Stop time #{@stop}"
#    break
#  end
#sleep 0.00001
#end

#while still_checking
#  if File.read(ECHO_VALUE_PATH) == "0"
#    start = Time.now.sec
#    still_checking = true
#    sleep 0.000001
#  elsif File.read(ECHO_VALUE_PATH) == "1"
#    stop = Time.now.sec
#    still_checking = false
#  end
#end
puts @start unless @start.nil?
puts @stop unless @stop.nil?

elapsed = @stop - @start

puts elapsed

distance = (elapsed * 34000)/2

puts "Distance: #{distance.round(2)} cm"

File.open("/sys/class/gpio/unexport", "w+") { |f| f.write(TRIGGER_PIN) }
File.open("/sys/class/gpio/unexport", "w+") { |f| f.write(ECHO_PIN) }

rescue => e
puts "#{e.class} => #{e.message}"

File.open("/sys/class/gpio/unexport", "w+") { |f| f.write(TRIGGER_PIN) }
File.open("/sys/class/gpio/unexport", "w+") { |f| f.write(ECHO_PIN) }
end
