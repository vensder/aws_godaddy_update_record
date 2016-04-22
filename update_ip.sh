#!/bin/bash

# update_ip.sh
# update godaddy dns record after aws instance rebooting
# sudo yum install python27-virtualenv.noarch

WORK_DIR="$HOME/aws_godaddy_update_record"
mkdir -p $WORK_DIR 
cd $WORK_DIR

# virtualenv env
source $WORK_DIR/env/bin/activate

date +%F-%R >> logfile.log
which python >> logfile.log
# pip install godaddypy
python aws_godaddy_record_update.py >> logfile.log
deactivate

# echo "/bin/bash $WORK_DIR/update_ip.sh" > /etc/rc.local
# echo 'touch /var/lock/subsys/local' >> /etc/rc.local

