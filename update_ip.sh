#!/bin/bash

# update_ip.sh
# update godaddy dns record after aws instance rebooting
# sudo yum install python27-virtualenv.noarch

cd "$( dirname "${BASH_SOURCE[0]}" )"

# virtualenv env
source env/bin/activate

date +%F-%R >> logfile.log
which python >> logfile.log
# pip install godaddypy
python aws_godaddy_record_update.py >> logfile.log
deactivate

# For autostart after reboting just add this script into /etc/rc.local

# echo '#!/bin/sh' > /etc/rc.local
# echo "/bin/bash $WORK_DIR/update_ip.sh" >> /etc/rc.local

# On CentOS-like systems:
# echo 'touch /var/lock/subsys/local' >> /etc/rc.local

# On Ubuntu-like systems:
# echo 'exit 0' >> /etc/rc.local
