#!/bin/bash

ZONE_ID="Z01312153HNV00B0UTMNI"
DOMAIN_NAME="bharath2103.online"

INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")

echo "========================================"
echo "Deleting Roboshop Infrastructure"
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

    if [ -z "$INSTANCE_ID" ]; then
        echo "No EC2 instance found."
    else
        echo "Terminating Instance: $INSTANCE_ID"

        aws ec2 terminate-instances \
            --instance-ids "$INSTANCE_ID" >/dev/null

        aws ec2 wait instance-terminated \
            --instance-ids "$INSTANCE_ID"

        echo "Instance terminated."
    fi

    if [ "$instance" = "frontend" ]; then
        RECORD_NAME="$DOMAIN_NAME"
    else
        RECORD_NAME="$instance.$DOMAIN_NAME"
    fi

    echo "Deleting Route53 record: $RECORD_NAME"

    IP=$(aws route53 list-resource-record-sets \
        --hosted-zone-id "$ZONE_ID" \
        --query "ResourceRecordSets[?Name=='${RECORD_NAME}.'].ResourceRecords[0].Value" \
        --output text)

    if [ -z "$IP" ] || [ "$IP" = "None" ]; then
        echo "Route53 record not found."
        continue
    fi

    aws route53 change-resource-record-sets \
        --hosted-zone-id "$ZONE_ID" \
        --change-batch "{
            \"Comment\":\"Deleting Route53 Record\",
            \"Changes\":[
                {
                    \"Action\":\"DELETE\",
                    \"ResourceRecordSet\":{
                        \"Name\":\"$RECORD_NAME\",
                        \"Type\":\"A\",
                        \"TTL\":1,
                        \"ResourceRecords\":[
                            {
                                \"Value\":\"$IP\"
                            }
                        ]
                    }
                }
            ]
        }"

    if [ $? -eq 0 ]; then
        echo "Route53 record deleted."
    else
        echo "Failed to delete Route53 record."
    fi

done

echo
echo "========================================"
echo "Roboshop cleanup completed."
echo "========================================"