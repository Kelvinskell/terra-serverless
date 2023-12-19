# terra-serverless
This is a terraform project that automates the deployment of a proof of concept for a serverless solution on AWS.

## Architecture

The architecture involved sending customer order details to an API Gateway.
The API Gateway is integrated with an SQS queue that stores the details and triggers a lambda function to process the order. The Lambda function processes the order, extracts important order details and stores them in a DynamoDB table.
This DynamoDB table has DynamoDB streams enabled which captures all "PUTItem" requests and transmits to a second Lambda function. This second Lambda function will then refine the purchase details and sends to a logistics team via SNS notifications.

## How to Use
- Clone the repository
- `cd` into the repository root directory
- Run `terraform init` command
- Run `terraform plan` to view the expected infrstructure changes
- Run `terraform apply` to deploy the infrastructure.
