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

On Ubuntu 14.04 you can get an error:
```
/home/ubuntu/aws_godaddy_update_record/env/local/lib/python2.7/site-packages/requests/packages/urllib3/util/ssl_.py:315: SNIMissingWarning: An HTTPS request has been made, but the SNI (Subject Name Indication) extension to TLS is not available on this platform. This may cause the server to present an incorrect TLS certificate, which can cause validation failures. For more information, see https://urllib3.readthedocs.org/en/latest/security.html#snimissingwarning.
  SNIMissingWarning
/home/ubuntu/aws_godaddy_update_record/env/local/lib/python2.7/site-packages/requests/packages/urllib3/util/ssl_.py:120: InsecurePlatformWarning: A true SSLContext object is not available. This prevents urllib3 from configuring SSL appropriately and may cause certain SSL connections to fail. For more information, see https://urllib3.readthedocs.org/en/latest/security.html#insecureplatformwarning.
  InsecurePlatformWarning
Traceback (most recent call last):
  File "aws_godaddy_record_update.py", line 37, in <module>
    a_records = client.get_a_records(MY_DOMAIN)
  File "/home/ubuntu/aws_godaddy_update_record/env/local/lib/python2.7/site-packages/godaddypy/client.py", line 112, in get_a_records
    data = self._get(url, headers=self._get_headers()).json()
  File "/home/ubuntu/aws_godaddy_update_record/env/local/lib/python2.7/site-packages/godaddypy/client.py", line 52, in _get
    resp = requests.get(url, **kwargs)
  File "/home/ubuntu/aws_godaddy_update_record/env/local/lib/python2.7/site-packages/requests/api.py", line 67, in get
    return request('get', url, params=params, **kwargs)
  File "/home/ubuntu/aws_godaddy_update_record/env/local/lib/python2.7/site-packages/requests/api.py", line 53, in request
    return session.request(method=method, url=url, **kwargs)
  File "/home/ubuntu/aws_godaddy_update_record/env/local/lib/python2.7/site-packages/requests/sessions.py", line 468, in request
    resp = self.send(prep, **send_kwargs)
  File "/home/ubuntu/aws_godaddy_update_record/env/local/lib/python2.7/site-packages/requests/sessions.py", line 576, in send
    r = adapter.send(request, **kwargs)
  File "/home/ubuntu/aws_godaddy_update_record/env/local/lib/python2.7/site-packages/requests/adapters.py", line 447, in send
    raise SSLError(e, request=request)
requests.exceptions.SSLError: hostname 'api.godaddy.com' doesn't match either of 'developer.godaddy.com', 'www.developer.godaddy.com'
```

Just update a  ndg-httpsclient with command:
```sh
source env/bin/activate
pip install --upgrade ndg-httpsclient
```
