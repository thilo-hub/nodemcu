--
-- prints a directory listing to the network after executing
--

	l = file.list();
	for k,v in pairs(l) do
	  m:publish(chn,id .. " :" .. k .. " " .. v ,qos,0)
	end
	

