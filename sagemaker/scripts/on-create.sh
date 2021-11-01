#!/bin/bash
whoami >> /tmp/on-create.txt
yum install cifs-utils unixODBC freetds -y

cat << "EOF" > /home/ec2-user/create-env.sh
unset SUDO_UID
KERNEL_NAME="hoopp-custom-conda"
PYTHON="3.7"
conda config --remove channels ocnda-forge
conda create --yes --name "$KERNEL_NAME" anaconda python="$PYTHON"
source activate "$KERNEL_NAME"
pip install --quiet ipykernel
pip install --quiet boto3
EOF

chmod +x /home/ec2-user/create-env.sh
chown ec2-user:ec2-user /home/ec2-user/create-env.sh
sudo -u ec2-user nohup /home/ec2-user/create-env.sh >> /home/ec2-user/nohup.out 2>&1 &