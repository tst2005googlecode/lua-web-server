----------------------------------------------------
-- Ladle web server.
-- Version 0.1.1.
-- Copyright (c) 2008 Samuel Saint-Pettersen.
-- Released under the GNU General Public License v3.
-- See the COPYING file.
----------------------------------------------------

-- load module for network connections.
socket = require("socket")

-- detect operating system
if os.getenv("WinDir") ~= nil then
	os = "Windows"
else
	os = "Other OS"  -- !
end

-- start web server.
function main(arg1) 
	-- set first argument as port
	port = arg1
	-- display initial program information.
	print("Ladle web server v0.1.1.")
	print("Copyright (c) 2008 Samuel Saint-Pettersen.")
	-- if no port is specified, use port 8080.
	if port == nil then port = 8080 end
	-- create tcp socket on localhost:%port%.
	server = assert(socket.bind("*", port))
	-- display message to web server is running
	print("\nRunning on localhost:" .. port)
	waitReceive() -- begin waiting for client requests.
end
-- wait for and receive client requests.
function waitReceive()
	-- loop while waiting for a client request.
	while 1 do
		-- accept a client request.
		client = server:accept()
		-- reply with standard web server response.
		client:send("HTTP/1.1 200/OK\r\nContent-Type: text/html\r\n\r\n")
		-- set timeout - 1 minute.
		client:settimeout(60)
		-- receive request from client.
		local request, err = client:receive()
		-- if there's no error, begin serving content or kill server.
		if not err then
			-- if request is kill (via telnet), stop the server.
			if request == "kill" then
				client:send("Ladle has stopped.")
				print("Stopped.")
				break
			else
				-- begin serving content.
				serve(request)
			end
		end
	end
end
-- serve requested content.
function serve(request)
	-- resolve requested file from client request.
	local file = string.match(request, "%l+%\/?.?%l+")
	-- if no file mentioned in request, assume root file is index.html.
	if file == nil then
		file = "index.html"
	end
	-- display requested file in browser
	local served = io.open("www/" .. file, "r")
	if served ~= nil then
		local content = served:read("*all")
		client:send(content)
	else
		-- display not found error.
		error("Not found!")
	end
	-- done with client, close request.
	client:close()
end
-- display error message and server information.
function error(message)
	client:send("Not found!")
end
-- invoke program starting point:
-- parameter is command-line argument for port number.
main(arg[1])
