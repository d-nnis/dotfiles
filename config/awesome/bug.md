
Possibly related to [this issue](https://github.com/lcpz/awesome-copycats/issues/217).

Contrary to being stated that awesome-copycats works with Awesome Version 4.x it does not appear to work with Awesome Version 4.0. Presumably the capabilities of Gears does not meet up: ```locate filesystem.lua``` does not find anything. 

Awesome starts, but throws erros. See version info and error log below.

Possible solution would be to require version > 4.0.

```
awesome v4.0 (Harder, Better, Faster, Stronger)
 • Compiled against Lua 5.1.5 (running with Lua 5.1)
 • D-Bus support: ✔
 • execinfo support: ✔
 • RandR 1.5 support: ✔
 • LGI version: 0.9.1
```

```
error while running function!
stack traceback:
	[C]: in function 'require'
	/home/dennis/.config/awesome/freedesktop/menu.lua:18: in main chunk
	[C]: in function 'require'
	/home/dennis/.config/awesome/freedesktop/init.lua:14: in main chunk
	[C]: in function 'require'
	/home/dennis/.config/awesome/rc.lua:20: in main chunk
error: /home/dennis/.config/awesome/freedesktop/menu.lua:18: module 'gears.filesystem' not found:
	no field package.preload['gears.filesystem']
	no file './gears/filesystem.lua'
	no file '/usr/local/share/lua/5.1/gears/filesystem.lua'
	no file '/usr/local/share/lua/5.1/gears/filesystem/init.lua'
	no file '/usr/local/lib/lua/5.1/gears/filesystem.lua'
	no file '/usr/local/lib/lua/5.1/gears/filesystem/init.lua'
	no file '/usr/share/lua/5.1/gears/filesystem.lua'
	no file '/usr/share/lua/5.1/gears/filesystem/init.lua'
	no file '/home/dennis/.config/awesome/gears/filesystem.lua'
	no file '/home/dennis/.config/awesome/gears/filesystem/init.lua'
	no file '/etc/xdg/awesome/gears/filesystem.lua'
	no file '/etc/xdg/awesome/gears/filesystem/init.lua'
	no file '/usr/share/awesome/lib/gears/filesystem.lua'
	no file '/usr/share/awesome/lib/gears/filesystem/init.lua'
	no file './gears/filesystem.so'
	no file '/usr/local/lib/lua/5.1/gears/filesystem.so'
	no file '/usr/lib/x86_64-linux-gnu/lua/5.1/gears/filesystem.so'
	no file '/usr/lib/lua/5.1/gears/filesystem.so'
	no file '/usr/local/lib/lua/5.1/loadall.so'
	no file './gears.so'
	no file '/usr/local/lib/lua/5.1/gears.so'
	no file '/usr/lib/x86_64-linux-gnu/lua/5.1/gears.so'
	no file '/usr/lib/lua/5.1/gears.so'
	no file '/usr/local/lib/lua/5.1/loadall.so'
```
