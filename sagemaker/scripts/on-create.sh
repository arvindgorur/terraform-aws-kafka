#!/bin/bash
whoami >> /tmp/on-create.txt
sudo yum install cifs-utils unixODBC freetds -y