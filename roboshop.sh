#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-05847b88288dddafe"
SUBNET_ID="subnet-027e9b95abbffe496"

INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")

ZONE_ID="Z01312153HNV00B0UTMNI"
DOMAIN_NAME="bharath2103.online"

# for instance in "${INSTANCES[@]}"
for instance in $@
do
    echo "==========================================="
    echo "Creating EC2 instance: $instance"

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
        continue
    fi

    echo "Instance ID : $INSTANCE_ID"

    echo "Waiting for instance to become running..."
    aws ec2 wait instance-running --instance-ids "$INSTANCE_ID"

    echo "Waiting for status checks..."
    aws ec2 wait instance-status-ok --instance-ids "$INSTANCE_ID"

    PRIVATE_IP=$(aws ec2 describe-instances \
        --instance-ids "$INSTANCE_ID" \
        --query "Reservations[0].Instances[0].PrivateIpAddress" \
        --output text)

    PUBLIC_IP=$(aws ec2 describe-instances \
        --instance-ids "$INSTANCE_ID" \
        --query "Reservations[0].Instances[0].PublicIpAddress" \
        --output text)

    echo "Private IP : $PRIVATE_IP"
    echo "Public IP  : $PUBLIC_IP"

    if [ "$instance" = "frontend" ]; then
        RECORD_NAME="$DOMAIN_NAME"
        DNS_IP="$PUBLIC_IP"
    else
        RECORD_NAME="$instance.$DOMAIN_NAME"
        DNS_IP="$PRIVATE_IP"
    fi

    if [ -z "$DNS_IP" ] || [ "$DNS_IP" = "None" ]; then
        echo "IP Address not available for $instance"
        continue
    fi

    aws route53 change-resource-record-sets \
        --hosted-zone-id "$ZONE_ID" \
        --change-batch "{
            \"Comment\":\"Updating Route53 Record\",
            \"Changes\":[
                {
                    \"Action\":\"UPSERT\",
                    \"ResourceRecordSet\":{
                        \"Name\":\"$RECORD_NAME\",
                        \"Type\":\"A\",
                        \"TTL\":1,
                        \"ResourceRecords\":[
                            {
                                \"Value\":\"$DNS_IP\"
                            }
                        ]
                    }
                }
            ]
        }"

    if [ $? -eq 0 ]; then
        echo "Route53 updated successfully."
    else
        echo "Route53 update failed."
    fi

    echo "==========================================="
    echo
done

echo "All instances processed successfully."