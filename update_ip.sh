#!/bin/bash

# update_ip.sh
# update godaddy dns record after aws instance rebooting
# sudo yum install python27-virtualenv.noarch

WORK_DIR='/home/ec2-user/python'
mkdir -p $WORK_DIR 
cd $WORK_DIR

# virtualenv env
source $WORK_DIR/env/bin/activate

date +%F-%R >> logfile.log
which python >> logfile.log
# pip install godaddypy
python aws_godaddy_record_update.py >> logfile.log
deactivate

# echo '/bin/bash /home/ec2-user/python/update_ip.sh' > /etc/rc.local
# echo 'touch /var/lock/subsys/local' >> /etc/rc.local

