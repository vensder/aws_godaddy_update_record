#!/usr/bin/env python
# -*- coding: utf-8 -*-

# python 2.7 required
# aws_godaddy_record_update.py

import logging
from godaddypy import Client, Account
from requests import get
from ConfigParser import ConfigParser

logging.basicConfig(
    filename='aws_godaddy.log',
    level = logging.DEBUG,
    format = u'%(filename)s[LINE:%(lineno)d]# %(levelname)-8s [%(asctime)s]  %(message)s')

logging.debug(u'=' * 60)

config = ConfigParser()
config.read('aws_godaddy.conf')

MY_DOMAIN = config.get('AWS', 'MY_DOMAIN')
MY_SUBDOMAIN = config.get('AWS', 'MY_SUBDOMAIN')
current_record = ''

r = get(u'http://169.254.169.254/latest/meta-data/public-ipv4')
public_ip = r.text

logging.debug(u'Public IP of the AWS instance: ' + public_ip)

my_acc = Account(
    api_key = config.get('GoDaddy', 'api_key'),
    api_secret = config.get('GoDaddy', 'api_secret'))
                
client = Client(my_acc)

a_records = client.get_a_records(MY_DOMAIN)

for d in a_records:
    if d[u'name'] == MY_SUBDOMAIN:
        current_record = d[u'data']
        break

if current_record == '':
    logging.error(u'GoDaddy DNS record for subdomain not found')
    raise ValueError(u'I can\'t find current DNS record')
else:
    logging.debug(u'Current DNS record: ' + current_record)

if public_ip == current_record:
    logging.debug(u'Public IP and current DNS record are the same (not needed to update)')
else:
    logging.debug(u'We need to update current DNS record')
    # uncomment string below for record updating
    client.update_ip(public_ip, domains=[MY_DOMAIN], subdomains=[MY_SUBDOMAIN])

