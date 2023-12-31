#!/bin/bash
#NAMES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "cart" "user" "shipping" "payments" "dispatch" "web")
NAMES=("mongodb" "redis")
IMAGE_ID=ami-03265a0778a880afb
SECURITY_GROUP_ID=sg-02aff670556d3d4d0
DOMAIN_NAME=ravidevops.cloud
for i in "${NAMES[@]}"
do
 if [[ $i == "mongodb" || $i == "mysql" ]]
 then
    INSTANCE_TYPE="t3.medium"
else
    INSTANCE_TYPE="t2.micro"
fi
echo "creating $i instance"
IP_ADDRESS=$(aws ec2 run-instances --image-id $IMAGE_ID  --instance-type $INSTANCE_TYPE  --security-group-ids $SECURITY_GROUP_ID --query 'Instances[0].PrivateIpAddress' --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=$i}]')
echo "created $i instance: $IP_ADDRESS"
    aws route53 change-resource-record-sets --hosted-zone-id Z01163212KDRMFKEXYVZE --change-batch '
     {
             "Changes": [{
             "Action": "CREATE",
                         "ResourceRecordSet": {
                            "Name": \"'$i.$DOMAIN_NAME\'",
                             "Type": "A",
                             "TTL": 300,
                             "ResourceRecords": [{ "Value": \"'$IP_ADDRESS\'"}]
                          }}]
             }
             '
    done