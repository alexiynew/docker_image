#!/bin/bash

# start up supervisord, all daemons should launched by supervisord.
/usr/bin/supervisord -c /root/supervisord.conf

cd /home/neutrino
sudo -u neutrino /bin/bash