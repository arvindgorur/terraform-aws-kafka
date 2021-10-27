#!/bin/bash
whoami >> /tmp/on-create.txt
URL="https://repo.anaconda.com/miniconda/Miniconda3-$VERSION-Linux-x86_64.sh"
echo $URL >> /tmp/on-create.txt
sudo -u ec2-user -i <<'EOF'
unset SUDO_UID
# Install a separate conda installation via Miniconda
WORKING_DIR=/home/ec2-user/SageMaker/custom-miniconda
mkdir -p "$WORKING_DIR"
wget --no-check-certificate https://repo.anaconda.com/miniconda/Miniconda3-$VERSION-Linux-x86_64.sh -O "$WORKING_DIR/miniconda.sh"
bash "$WORKING_DIR/miniconda.sh" -b -u -p "$WORKING_DIR/miniconda"
rm -rf "$WORKING_DIR/miniconda.sh"
# Create a custom conda environment
source "$WORKING_DIR/miniconda/bin/activate"
KERNEL_NAME="hoopp-custom-conda"
PYTHON="3.7"
conda create --yes --name "$KERNEL_NAME" anaconda python="$PYTHON"
conda activate "$KERNEL_NAME"
pip install --quiet ipykernel
pip install --quiet boto3
EOF
