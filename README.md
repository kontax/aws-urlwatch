# aws-urlwatch
[![Docker Build and Push](https://github.com/kontax/aws-urlwatch/actions/workflows/docker-build-and-push.yml/badge.svg)](https://github.com/kontax/aws-urlwatch/actions/workflows/docker-build-and-push.yml) [![AWS SAM Pipeline](https://github.com/kontax/aws-urlwatch/actions/workflows/aws-sam-pipeline.yml/badge.svg)](https://github.com/kontax/aws-urlwatch/actions/workflows/aws-sam-pipeline.yml)

An AWS-based [urlwatch](https://github.com/thp/urlwatch) running on ECS which periodically runs the program to scan for any updates to select web-pages.

## Architecture

### cloud-urlwatch
[cloud-urlwatch](cloud-urlwatch) contains the AWS-SAM template which outlines the different applications for the project.

### docker-urlwatch
[docker-urlwatch](docker-urlwatch) contains the docker template and configuration files for urlwatch.

## Usage

1. Update the [urls.yaml](docker-urlwatch/scripts/urls.yaml) with the URL's to be tracked, as defined in the [urlwatch documentation](urlwatch.readthedocs.com).
2. Create a secret named `cloud-urlwatch/email-details` to [AWS Secrets Manager](https://console.aws.amazon.com/secretsmanager), and add the following key/value secrets:
    * EmailHost: The SMTP host used to send emails from
    * EmailPort: The SMTP port used to send emails from
    * EmailUser: The username used to send emails over the SMTP host
    * EmailPass: The password for the EmailUser
    * EmailFrom: The email address the urlwatch mail comes from
    * EmailRcpt: The recipient of the urlwatch mail
3. Create a [pushover](https://pushover.net) application to send push notifications to a phone on errors.
4. Create new parameters within [AWS Parameter Store](https://console.aws.amazon.com/systems-manager/parameters/) named `pushoverToken` and `pushoverUser` containing the user and token created in the previous step.
5. Navigate to [cloud-urlwatch](cloud-urlwatch) and run the command below, ensuring to update the parameters with those set up in the previous steps, which can all be found in [samconfig.toml](cloud-urlwatch/samconfig.toml). Note the S3 bucket will be different after running the command:
`sam build --use-container && sam deploy --guided`

