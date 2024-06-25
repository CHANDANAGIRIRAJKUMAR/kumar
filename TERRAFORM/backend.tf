terraform {
  backend "s3" {
    bucket = "abcdefnjonknknk"
    key    = "statefile/terraform-statefile"
    region = "us-west-2"
  }
}

