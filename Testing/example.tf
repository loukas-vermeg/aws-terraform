module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "learn-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# resource "aws_instance" "web" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t3.micro"

#   tags = {
#     Name = "HelloWorld"
#   }
# }

module "my_ec2_instance" {
  source              = "./modules/AWS_VPC"
  ec2_instance_type   = var.ec2_instance_type
  ec2_instance_name   = var.ec2_instance_name
  number_of_instances = var.number_of_instances
  ec2_ami_id          = data.aws_ami.ubuntu.id

}

output "instance_id" {
  value = module.my_ec2_instance.ec2_instance_id
}


