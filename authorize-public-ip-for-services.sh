#!/bin/bash

# This script authorizes the publicly-addressable of a user's machine
# with various ports needed to access the barker services boxes, e.g.
# Consul, Asgard, Kibana and Elasticsearch.
#
# It requires that AWS Command Line tools are installed and that a profile
# named "barker" is configured with the IAM credentials to make these changes.
#
# You will also need to change SECURITY_GROUP_ID
# to match the ID for the security group assigned to the barker services instance. 

SECURITY_GROUP_NAME="barker-services"
AWS_CLI_PROFILE_NAME="barker"
PUBLIC_IP_ADDRESS=`dig +short myip.opendns.com @resolver1.opendns.com`
SECURITY_GROUP_ID="sg-bbd561dc"

TCP_PORTS=(3333 5000 5601 8080 8500 9200)

for p in "${TCP_PORTS[@]}"
do
	echo "Authorizing IP '${PUBLIC_IP_ADDRESS} to access port ${p}"
	aws ec2 authorize-security-group-ingress --profile $AWS_CLI_PROFILE_NAME --group-id $SECURITY_GROUP_ID --protocol tcp --port $p --cidr "${PUBLIC_IP_ADDRESS}/32"
done