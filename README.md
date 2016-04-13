# Update GoDaddy DNS A record for AWS instance
Update GoDaddy DNS A record for AWS instance, using GoDaddyPy python library.

[GoDaddyPy](https://github.com/eXamadeus/godaddypy) - Python library useful for updating DNS settings through the GoDaddy v1 API.

AWS Instances very often change their public IP addresses (after rebooting, reconfiguring etc.)
This script allow you to update actual IP address of AWS instance in A record subdomain name in GoDaddy DNS.

GoDaddyPy library works only with Python v. 2.7.

We recommend to use virtualenv.

For example, do this in CentOS-like distros:

```bash
sudo yum install python27-virtualenv.noarch
virtualenv env
source env/bin/activate
pip install godaddypy
```

You can add running command of the script into file `/etc/rc.local` for auto starting after rebooting.
This is example of the `/etc/rc.local` file:

```sh
#!/bin/sh
#
# This script will be executed *after* all the other init scripts.
# You can put your own initialization stuff in here if you don't
# want to do the full Sys V style init stuff.

/bin/bash /home/ec2-user/python/update_ip.sh

touch /var/lock/subsys/local
```

