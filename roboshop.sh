#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-05847b88288dddafe" # replace with your SG ID
INSTANCE=("mongodb" "redis" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")
ZONE_ID="Z09266885JREMC64NO1J"
DOMAIN_NAME="bharath2103.site"