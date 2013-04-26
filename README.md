lxc-scripts
===========

create.sh
---------
Create an LXC container

	Usage: ./create.sh -i <ip address> -p <path> -t <template> -r [name]
	  -i            optional: IP address/mask
	  -p            optional: path to save machine (default current path)
	  -t            optional: machine template (default "default")
	  -r            optional: rebuild template
	  name          machine name
<br>


start.sh
--------
Start an LXC container

	Usage: ./start.sh -l <path> -p <path> -i -q [name]
	  -i            optional: interactive mode (not daemonized)
	  -q            optional: disable daemon console logging
	  -l            optional: log file path
	  -p            optional: machine path
	  name          machine name
<br>


destroy.sh
----------
Destroy an LXC container

	Usage: ./destroy.sh [name] [path]
	  name			machine name
	  path			optional: path to save machine
	  				(assumes current path)
<br>


network-interfaces
------------------
Copy of <code>/etc/network/interfaces</code> for happy bridging
<br>


lxc-default
-----------
"Default" LXC container template used by scripts.  Builds a fairly minimal Ubuntu 12.04 x64 container.
