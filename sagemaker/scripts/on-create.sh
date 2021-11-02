#!/bin/bash
whoami >> /tmp/on-create.txt
yum install cifs-utils unixODBC freetds -y

cat << "EOF" > /home/ec2-user/SageMaker/create-env.sh
unset SUDO_UID
WORKING_DIR=/home/ec2-user/SageMaker/custom-miniconda
mkdir -p "$WORKING_DIR"
KERNEL_NAME="hoopp-custom-conda"
PYTHON="3.7"
wget https://repo.anaconda.com/miniconda/${VERSION} -O "$WORKING_DIR/miniconda.sh"
bash "$WORKING_DIR/miniconda.sh" -b -u -p "$WORKING_DIR/miniconda" 
rm -rf "$WORKING_DIR/miniconda.sh"
source "$WORKING_DIR/miniconda/bin/activate"
#BIN_PATH=/home/ec2-user/anaconda3/condabin
conda config --remove channels conda-forge
conda create --yes --name "$KERNEL_NAME" anaconda python="$PYTHON"
conda activate "$KERNEL_NAME"
#conda config --add channels conda-forge
pip install --quiet ipykernel
pip install --quiet boto3
EOF

chmod +x /home/ec2-user/SageMaker/create-env.sh
chown ec2-user:ec2-user /home/ec2-user/SageMaker/create-env.sh
sudo -u ec2-user nohup /home/ec2-user/SageMaker/create-env.sh >> /home/ec2-user/SageMaker/nohup.out 2>&1 &