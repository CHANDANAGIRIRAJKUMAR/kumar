terraform {
  backend "s3" {
    bucket = "my654654483560"
    key    = "statefile/terraform-statefile"
    region = "us-east-1"
  }
}
