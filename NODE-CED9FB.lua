T=500000
fz={}
LED=4
RELAY=1
gpio.mode(LED,gpio.OUTPUT,gpio.PULLUP)
gpio.mode(RELAY,gpio.OUTPUT,gpio.PULLUP)

function relay(v)
	gpio.write(LED, v and  gpio.LOW or gpio.HIGH)
	gpio.write(RELAY, v and  gpio.HIGH or gpio.LOW)
end
gpio.serout(RELAY,gpio.HIGH,{T,T},10,function() end)
mq_ops["relay"] = function(msg)
	relay(msg == "on")
end
	

	


