#!/bin/bash
whoami >> /tmp/on-create.txt
sudo yum install cifs-utils unixODBC-devel freetds -y
URL="https://repo.anaconda.com/miniconda/${VERSION}"
echo $URL >> /tmp/on-create.txt
cat << "EOF" > /home/ec2-user/create-env.sh
unset SUDO_UID
# Install a separate conda installation via Miniconda
WORKING_DIR=/home/ec2-user/SageMaker/custom-miniconda
mkdir -p "$WORKING_DIR"
wget --no-check-certificate https://repo.anaconda.com/miniconda/${VERSION} -O "$WORKING_DIR/miniconda.sh"
bash "$WORKING_DIR/miniconda.sh" -b -u -p "$WORKING_DIR/miniconda"
rm -rf "$WORKING_DIR/miniconda.sh"
# Create a custom conda environment
source "$WORKING_DIR/miniconda/bin/activate"
KERNEL_NAME="hoopp-custom-conda"
PYTHON="3.7"
conda config --remove channels conda-forge
conda create --yes --name "$KERNEL_NAME" anaconda python="$PYTHON"
EOF

chomd +x /home/ec2-user/create-env.sh
chown ec2-user:ec2-user /home/ec2-user/create-env.sh
sudo -u ec2-user nohup /home/ec2-user/create-env.sh