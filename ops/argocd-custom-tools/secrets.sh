#!/bin/bash

: ${REGION:="us-east-1"}
: ${TIER:="prod"}

function getParameter() {
  local key=$1
  aws ssm get-parameter --name $key \
    --with-decryption \
    --query "Parameter.Value" \
    --region $REGION \
    --output text
}

: ${SWAGGER_ENABLED:=$(getParameter "/$TIER/shared/swagger")}




#aws ssm put-parameter \
#    --region "us-east-1" \
#    --name "/dev/shared/swagger" \
#    --value "true" \
#    --type "SecureString"
#
#aws ssm put-parameter \
#    --region "us-east-1" \
#    --name "/prod/shared/swagger" \
#    --value "false" \
#    --type "SecureString"
#
#aws ssm get-parameter --name /dev/shared/swagger \
#  --with-decryption \
#  --query "Parameter.Value" \
#  --region us-east-1 \
#  --output text

echo $SWAGGER_ENABLED

