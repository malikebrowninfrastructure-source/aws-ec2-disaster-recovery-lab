provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project    = "ec2-disaster-recovery-lab"
      ManagedBy  = "Terraform"
      Enviroment = "Lab"
    }
  }
}
