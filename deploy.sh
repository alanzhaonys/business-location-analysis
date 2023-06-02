#!/bin/bash

# e.g. nailsalon-location-analysis, this is the CloudFormation stack name
APP_NAME=[REPLACE-ME]
# e.g. default or your custom profile
PROFILE=[REPLACE-ME]
# e.g. us-east-1 or us-west-2
REGION=[REPLACE-ME]
# e.g. the bucket you just created to hold nested CloudFormation templates
CLOUDFORMATION_BUCKET=[REPLACE-ME]

aws cloudformation package \
  --template-file template.yaml \
  --output-template-file template.packaged.yaml \
  --s3-bucket $CLOUDFORMATION_BUCKET \
  --s3-prefix $APP_NAME \
  --force-upload \
  --profile $PROFILE

aws cloudformation deploy \
  --template-file template.packaged.yaml \
  --stack-name $APP_NAME \
  --s3-bucket $CLOUDFORMATION_BUCKET \
  --tags Application=$APP_NAME \
  --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
  --region $REGION \
  --profile $PROFILE

