--
-- add some functions to the mqtt interpreter
--
--
-- these can then be called using:
--
-- mosquitto_pub -h mqtt-server  -t "node" -m "node-id {function} [parameter]"
--

mq_ops["test"] = function(msg)
	m:publish(chn,id .. " testing" ,qos,0)
end
mq_ops["identify"] = function(msg)
	LED=4
	gpio.mode(LED,gpio.OUTPUT,gpio.PULLUP)
	gpio.serout(LED,gpio.HIGH,{500000,500000},100,1)
end
mq_ops["ls"] = function(msg)
	l = file.list();
	for k,v in pairs(l) do
	  m:publish(chn,id .. " :" .. k .. " " .. v ,qos,0)
	end
end
	

