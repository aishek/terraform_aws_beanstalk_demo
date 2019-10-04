# Terraform AWS Beanstalk sample

## Setup

1. terraform v0.12.9
2. `terraform init`
3. ~/.aws/credentials

    # ~/.aws/credentials
    [default]
    aws_access_key_id = YOUR_ACCESS_KEY
    aws_secret_access_key = YOUR_SECRET_ACCESS_KEY

## Run

    terraform apply

## Deploy

1. Build next version docker image `docker build -t aishek/rails_aws_beanstalk:1.0.11 .`
2. Push image `docker image push aishek/rails_aws_beanstalk:1.0.11`
3. create `Dockerrun.aws.json`:

    # Dockerrun.aws.json
    {
      "AWSEBDockerrunVersion": "1",
      "Image": {
        "Name": "aishek/rails_aws_beanstalk:1.0.11",
        "Update": "true"
      },
      "Ports": [
        {
          "ContainerPort": "3000"
        }
      ],
      "Logging": "/app/log"
    }

4. Zip `Dockerrun.aws.json` to `v3.zip` file
5. Upload to AWS S3 to `sample-versions` bucket to `/rails-test`
6. Add new `aws_elastic_beanstalk_application_version` to `beanstalk.tf` (copy exiting and change `name` and `key`)
7. Change `version_label` for env to deploy
8. In `route53.tf` change `aws_route53_record.www`'s `name` to env
9. `terraform apply`
