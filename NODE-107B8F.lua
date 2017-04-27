--
-- This file will only be loaded on a node with the same name as the file
--
-- it add a new function to the gpio's which sends a message
-- if the button is pressed

-- debouncing is crap -- needs fixing

T=500000
LED=4
BUTTON=1
tlast=tmr.now()

nd="NODE-CED9FB relay"

button = function(level,when)
	local dt=when-tlast
	tlast=when
	if dt > 200000 then
		m:publish(chn,nd .. (level == 1  and " on" or " off") ,qos,0)
		print("Button: "..level)
		gpio.write(LED,level)
	end
     end

gpio.mode(LED,gpio.OUTPUT,gpio.PULLUP)
gpio.mode(BUTTON,gpio.INT,gpio.PULLUP)
gpio.trig(BUTTON,"both", button)
