--------------------------------
Ladle web server
--------------------------------

Prerequisites:

* Lua interpreter
* LuaSocket
* CGILua
* XML4Lua

=============================================================

To start the Ladle web server:

1) Open up a shell prompt
2) Navigate to directory containing ladle.lua
3) Run "webs" script

Make sure that the Lua intepreter is in your PATH
or you will have to type the full path to the Lua interpeter
e.g. /path/to/lua ladle.lua

The server runs by default on port 80 and can be accessed in 
a web browser with http://localhost

Files served by the server should be placed in /www

=============================================================

To stop the Ladle web server:

1) Open up a shell prompt
2) Navigate to directory containing laldle.lua
3) Run "telin" script followed by port number

   -> E.g. "telin 80" or "./telin.sh 80"
      if you ran the server on port 80

4) Type "kill" and hit return

=============================================================