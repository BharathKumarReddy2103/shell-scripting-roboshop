#!/bin/bash

INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")

echo "========================================"
echo "Deleting Roboshop EC2 Instances"
echo "========================================"

for instance in "${INSTANCES[@]}"
do
    echo
    echo "Processing: $instance"

    INSTANCE_ID=$(aws ec2 describe-instances \
        --filters "Name=tag:Name,Values=$instance" \
                  "Name=instance-state-name,Values=pending,running,stopping,stopped" \
        --query "Reservations[].Instances[].InstanceId" \
        --output text)

    if [ -z "$INSTANCE_ID" ] || [ "$INSTANCE_ID" = "None" ]; then
        echo "No EC2 instance found for $instance"
        continue
    fi

    echo "Instance ID: $INSTANCE_ID"
    echo "Terminating instance..."

    aws ec2 terminate-instances \
        --instance-ids "$INSTANCE_ID" >/dev/null

    echo "Waiting for termination..."

    aws ec2 wait instance-terminated \
        --instance-ids "$INSTANCE_ID"

    echo "✅ $instance terminated successfully."

done

echo
echo "========================================"
echo "All Roboshop EC2 instances have been terminated."
echo "Route53 records were NOT deleted."
echo "========================================"