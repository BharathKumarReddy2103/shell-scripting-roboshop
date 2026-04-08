#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-05847b88288dddafe" # replace with your SG ID
SUBNET_ID="subnet-027e9b95abbffe496"
INSTANCE=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")
ZONE_ID="Z09266885JREMC64NO1J"
DOMAIN_NAME="bharath2103.site"

#for instance in ${INSTANCES[@]}
for instance in $@
do
  EXTRA="--associate-public-ip-address"

    INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type t3.micro \
    --security-group-ids $SG_ID \
    --subnet-id $SUBNET_ID \
    $EXTRA \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name, Value=$instance}]" \
    --query "Instances[0].InstanceId" \
    --output text)

    echo "Created $instance → $INSTANCE_ID"

   # WAIT until instance is running
   aws ec2 wait instance-running --instance-ids $INSTANCE_ID

    if [ "$instance" != "frontend" ]
    then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID \
        --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)

        RECORD_NAME="$instance.$DOMAIN_NAME"

    else
        echo "Waiting for Public IP..."

        while true; do
            IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID \
            --query "Reservations[0].Instances[0].PublicIpAddress" --output text)

           if [ "$IP" != "None" ]; then
               break
           fi

           sleep 5
        done

        RECORD_NAME="$DOMAIN_NAME"
    fi

    echo "$instance IP address: $IP"

    aws route53 change-resource-record-sets \
    --hosted-zone-id $ZONE_ID \
    --change-batch '
    {
        "Comment": "Creating or Updating a record set for cognito endpoint"
        ,"Changes": [{
        "Action"              : "UPSERT"
        ,"ResourceRecordSet"  : {
            "Name"              : "'$RECORD_NAME'"
            ,"Type"             : "A"
            ,"TTL"              : 1
            ,"ResourceRecords"  : [{
                "Value"         : "'$IP'"
            }]
        }
        }]
    }'
done