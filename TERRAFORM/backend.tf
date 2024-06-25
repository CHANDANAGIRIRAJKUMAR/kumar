terraform {
  backend "s3" {
    bucket = "abcdefnjonknknk" # replace with s3 bucket
    key    = "statefile/terraform-statefile"
    region = "us-west-2"
  }
}

