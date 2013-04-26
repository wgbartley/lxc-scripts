lxc-scripts
===========
My own little set of scripts for messing around with LXC containers.  Inspired by [Vagrant](http://www.vagrantup.com) without the extra hassle.
<br>
<br>


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
<br>


lxc-default
-----------
"Default" LXC container template used by scripts.  Builds a fairly minimal Ubuntu 12.04 x64 container.
<br>
<br>


Tips
----
I copied the <code>\*.sh</code> files to <code>/usr/local/bin/</code> for ease of use:

* <code>create.sh</code> &rarr; <code>/usr/local/bin/glxc-create</code>
* <code>destroy.sh</code> &rarr; <code>/usr/local/bin/glxc-destroy</code>
* <code>start.sh</code> &rarr; <code>/usr/local/bin/glxc-destroy</code>
