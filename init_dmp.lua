--
--
--  Helper function which dumps a variable
-- any variable

function dmp(var)
	local dne={}
	function _dmp(m,var)
	   local tp=type(var)
	   if tp == "table" or tp == "romtable" then
		   for i,v in pairs(var) do
			if not dne[v] then
				dne[v]=1
				--print(" ",m.."= ")
				_dmp(m.."."..i,v)
			end
		   end
	   else
			print(m,"("..tp..") =>'" .. tostring(var) .. "'")
	   end
	end
_dmp("",var)
end

--dmp(getfenv())

print("dmp function loaded")
