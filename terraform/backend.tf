terraform {
  # The S3 backend actually is meant to be an AWS S3 Bucket.
  # It is possible to use another S3 bucket, but a few things need to be set.
  # skip_credentials_validation = true to disable AWS Security Token Service verification.
  # endpoint = "whatever-endpoint" to the actually used S3 service.
  # region = "valid-aws-region" even if not used.
  # If pulled from an env variable access_key must be AWS_ACCESS_KEY_ID If pulled from an env variable secret_key must be AWS_SECRET_ACCESS_KEY
  #
  # This of course does not provide state locking via dynamoDB and should not be used in
  # any kind of procution setup.
  backend "s3" {
    bucket                      = "oliverwiegers-terraform-state"
    key                         = "terraform.tfstate"
    region                      = "us-east-1" # Is wrong and not used. But needs to be set to a valid AWS region.
    endpoint                    = "fsn1.your-objectstorage.com"
    skip_credentials_validation = true
  }
}
