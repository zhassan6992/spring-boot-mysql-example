terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "eu-west-2"
}

resource "aws_instance" "app_server" {
  ami = "ami-830c94e3"
  instance_type = "t2.micro"

    ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 100GB
  }

  root_block_device {
    volume_size = 20GB
    volume_type = "gp3"
    encrypted   = true
    kms_key_id  = data.aws_kms_key.customer_master_key.arn
  }

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
