----------------------------------------------------
-- Web server
-- Version 0.1
-- Copyright (c) 2008 Samuel Saint-Pettersen
-- Released under the GNU General Public License V3
-- See the COPYING file
----------------------------------------------------

-- load module for network connections
local socket = require("socket")

-- print message to show web server is running
print("Web server v0.1")
print("Copyright (c) 2008 Samuel Saint-Pettersen\n")
print("Running...")

-- create TCP socket on localhost:8080
local server = assert(socket.bind("*", 8080))
-- loop while waiting for a user agent request
while 1 do
	-- wait for a connection
	local client = server:accept()
	-- send response to confirm this is a web server
	client:send("HTTP/1.1 200/OK\r\nContent-Type:text/html\r\n\r\n")
	-- set timeout - 1 minute
	client:settimeout(60)
	-- receive request from user agent
	local request, err = client:receive()
	-- if there's no error, return the requested page
	if not err then 
		-- the server can be killed, by telnetting in
		-- and sending the request -> kill
		if request == "kill" then
			client:send("Web server killed.\n")
			print("Stopped.")
			break
		else
			-- detect operating system
			local os = os.getenv("WinDir")
			if os ~= nil then
				os = "Windows"
			else
				os = "Unix-like"
			end	
			-- resolve requested file from user agent request
			local file = string.match(request, "%l+%.?%l+")
			-- if no file mentioned in request, assume root file is index.html
			if file == nil then
				file = "index.html"
			end
			-- display requested file in browser
			local served = io.open("www/" .. file, "r")
			if served ~= nil then
				local content = served:read("*all")
				client:send(content)
			else
			-- display 404 message and server information
				client:send("<h3>404 Not Found!</h3>")
				client:send("<hr/>")
				client:send("<small>Lua web server v0.1 (" .. os ..")</small>")
			end
		end
	end
	-- done with client, close request
	client:close()
end

