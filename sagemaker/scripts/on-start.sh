#!/bin/bash
whoami >> /tmp/on-start.txt
yum install cifs-utils unixODBC freetds -y

cat << "EOF" > /home/ec2-user/on-start.sh
unset SUDO_UID
KERNEL_NAME="hoopp-custom-conda"
BIN_PATH=/home/ec2-user/anaconda3/condabin
source $BIN_PATH/activate "$KERNEL_NAME"
python -m ipykernel install --user --name "$KERNEL_NAME" --display-name "Custom ($KERNEL_NAME)"
EOF

chmod +x /home/ec2-user/on-start.sh
chown ec2-user:ec2-user /home/ec2-user/on-start.sh
# sudo -u ec2-user nohup /home/ec2-user/on-start.sh >> /home/ec2-user/nohup.out 2>&1 &