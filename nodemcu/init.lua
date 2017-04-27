--
-- init.lua is loaded at node-start
--
-- it will include all files init_*
--
--
station_cfg={}
station_cfg.ssid="here"
station_cfg.pwd= -------------
station_cfg.save=true

sys_version="1.0"

print('init.lua ver 1.3')

wifi.sta.eventMonReg(wifi.STA_IDLE, function() print("STATION_IDLE") end)
wifi.sta.eventMonReg(wifi.STA_CONNECTING, function() print("STATION_CONNECTING") end)
wifi.sta.eventMonReg(wifi.STA_WRONGPWD, function() print("STATION_WRONG_PASSWORD") end)
wifi.sta.eventMonReg(wifi.STA_APNOTFOUND, function() print("STATION_NO_AP_FOUND") end)
wifi.sta.eventMonReg(wifi.STA_FAIL, function() print("STATION_CONNECT_FAIL") end)
wifi.sta.eventMonReg(wifi.STA_GOTIP, function() print("STATION_GOT_IP") end)


wifi.setmode(wifi.STATION,true)
print('set mode=STATION (mode='..wifi.getmode()..')')
print('Host: '..wifi.sta.gethostname())
print('MAC: ',wifi.sta.getmac())
print('chip: ',node.chipid())
print('heap: ',node.heap())
-- wifi config start
wifi.sta.config(station_cfg)
-- wifi config end
for n,l  in pairs(file.list()) do 
	if string.match(n,"init_.*l[ua|c]") then
		print(l,n)
		dofile(n)
	end
end

