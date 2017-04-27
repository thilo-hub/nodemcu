srvr="ts2.nispuk.com"
srvr="192.168.0.11"
chn="node"
id=wifi.sta.gethostname()
qos=2

gpio.mode(1,gpio.INPUT,gpio.PULLUP)
-- gpio.mode(3,gpio.OUTPUT,gpio.PULLUP)

gpio.trig(1,"both", function(level,when)
    m:publish(chn,"TRIGGER " .. id .. " " .. level .. " " .. when,qos,0)
    end
)

m = mqtt.Client(id, 120)

m:on("connect", 
   function(client) 
     print ("connected") 
     m:lwt(chn, "offline " .. id, 0, 0)
     m:subscribe(chn,qos)
     m:publish(chn,"Hello " .. sys_version .. " "  .. id .. " " .. wifi.sta.getip() ,qos,0)
   end
)
mq_ops = {
open = function(msg) fh=file.open(msg,"w") 
	end,
bwrite = function(msg)
	local f=encoder.fromBase64(msg)
	fh:write(f)
	end,
write = function(msg) fh:write(msg .. "\\n")
	end,
close = function(msg) 
	fh:close()
	m:publish(chn,id .. " R:loaded" ,qos,0)
	end,
dofile = function(msg) 
	m:publish(chn,id .. " R:execute" ,qos,0)
	dofile(msg)
	m:publish(chn,id .. " R:finish" ,qos,0)
	end,
set = function(msg) 
	gpio.write(3,msg == "HIGH" and gpio.HIGH or gpio.LOW )
	end ,
status = function(msg) 
	m:publish(chn,"GPIO " .. gpio.read(1),qos,0)
	end ,
reset = function() node.restart() end,
}

parse = function (a,b,msg) 
	-- print ("X-C:",a) 
	print ("T:",b , msg) 
	-- print("M:",msg) 
	local r;
        msg=msg:gsub("(%S+)%s?",function(c) r = c return "" end, 1 )
        -- dmp({r,msg})
	if r == id  then 
		msg=msg:gsub("(%S+)%s?",function(c) r = c return "" end, 1 )
		-- dmp(msg)
		local f = mq_ops[r] or function() end
		f(msg)
	elseif r == "status"  then 
	     m:publish(chn,id .. " running" ,qos,0)
	end 
    end 

m:on("message",parse)
m:on("offline", function(client) print ("offline") end)
--m:connect(srvr)
wifi.sta.eventMonReg(wifi.STA_GOTIP, function() 
	print("STATION_GOT_IP:",wifi.sta.getip()) 
	m:connect(srvr) 
	local l_opt=id .. ".lua"
	if file.exists(l_opt) then
		dofile(l_opt)
	end
end)


