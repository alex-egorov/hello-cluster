#!/bin/bash -e


RESOURCE_LIST=$(cat) # read the `kind: ResourceList` from stdin
REGION=$(echo "${RESOURCE_LIST}" | yq e -o=j - | jq -cr '.functionConfig.region')
#REGION=$(echo "${RESOURCE_LIST}" | yq e '.functionConfig.region' -)

function getParameter() {
  local key=$1
  aws ssm get-parameter --name $key \
    --with-decryption \
    --query "Parameter.Value" \
    --region $REGION \
    --output text
}

echo "
kind: ResourceList
items:
- kind: Secret
  apiVersion: v1
  metadata:
    name: the-map
  data:
"

for k in $(echo "${RESOURCE_LIST}" | yq e -o=j - | jq -cr '.functionConfig.data | keys[]'); do
      val=$(echo "${RESOURCE_LIST}" | yq e -o=j - | jq -cr ".functionConfig.data.${k}")
      param=$(getParameter $val)

      echo "    ${k}: ${param}"
done

echo "    aaa: bbb"
echo "    ccc: ddd"


