#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-05847b88288dddafe"
SUBNET_ID="subnet-027e9b95abbffe496"

INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")

ZONE_ID="Z01312153HNV00B0UTMNI"
DOMAIN_NAME="bharath2103.online"

# for instance in "${INSTANCES[@]}"
for instance in "$@"
do
    echo "Creating EC2 instance: $instance..."

    INSTANCE_ID=$(aws ec2 run-instances \
        --image-id "$AMI_ID" \
        --instance-type t3.micro \
        --subnet-id "$SUBNET_ID" \
        --security-group-ids "$SG_ID" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
        --query "Instances[0].InstanceId" \
        --output text)

    if [ $? -ne 0 ] || [ -z "$INSTANCE_ID" ]; then
        echo "Failed to create instance: $instance"
        echo "--------------------------------------------"
        continue
    fi

    echo "Instance ID: $INSTANCE_ID"
    echo "Waiting for instance to enter running state..."

    aws ec2 wait instance-running --instance-ids "$INSTANCE_ID"

    if [ "$instance" != "frontend" ]; then
        IP=$(aws ec2 describe-instances \
            --instance-ids "$INSTANCE_ID" \
            --query "Reservations[0].Instances[0].PrivateIpAddress" \
            --output text)

        RECORD_NAME="$instance.$DOMAIN_NAME"
    else
        IP=$(aws ec2 describe-instances \
            --instance-ids "$INSTANCE_ID" \
            --query "Reservations[0].Instances[0].PublicIpAddress" \
            --output text)

        RECORD_NAME="$DOMAIN_NAME"
    fi

    echo "$instance IP Address: $IP"

    aws route53 change-resource-record-sets \
        --hosted-zone-id "$ZONE_ID" \
        --change-batch '{
            "Comment":"Creating or Updating Route53 Record",
            "Changes":[{
                "Action":"UPSERT",
                "ResourceRecordSet":{
                    "Name":"'"$RECORD_NAME"'",
                    "Type":"A",
                    "TTL":1,
                    "ResourceRecords":[
                        {
                            "Value":"'"$IP"'"
                        }
                    ]
                }
            }]
        }'

    echo "Route53 record updated for $RECORD_NAME"
    echo "--------------------------------------------"
done