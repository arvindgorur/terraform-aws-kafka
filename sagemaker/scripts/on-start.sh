#!/bin/bash
whoami >> /tmp/on-start.txt
yum install cifs-utils unixODBC freetds -y

cat << "EOF" > /home/ec2-user/SageMaker/activate-env.sh
COUNT=0
LOG_FILE=/home/ec2-user/SageMaker/create-env.log
while [ $COUNT -le 20 ]
do
    cat $LOG_FILE | grep "Done installing custom environment"
    EXIT_CODE=$?
    if [ $EXIT_CODE -eq 0 ]
    then
        WORKING_DIR=/home/ec2-user/SageMaker/custom-miniconda/
        source "$WORKING_DIR/miniconda/bin/activate"
        for env in $WORKING_DIR/miniconda/envs/*; do
           BASENAME=$(basename "$env")
           source activate "$BASENAME"
           python -m ipykernel install --user --name "$BASENAME" --display-name "Custom ($BASENAME)"
        done
        echo "Done activating custom environments"
        break
    else
        echo "Waiting..."
        sleep 1m
        ((COUNT=COUNT+1))
    fi
done
EOF

chmod +x /home/ec2-user/SageMaker/activate-env.sh
chown ec2-user:ec2-user /home/ec2-user/SageMaker/activate-env.sh
sudo -u ec2-user nohup /home/ec2-user/SageMaker/activate-env.sh >> /home/ec2-user/SageMaker/activate-env.log 2>&1 &