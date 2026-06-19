terraform {
  backend "s3" {
    bucket = "infra-deployment-terraform-state-trensstore"
    key    = "dev/terraform.tfstate"
    region = "ap-southeast-1"
    use_lockfile = true
  }
}