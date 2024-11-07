region_name         = "eu-north-1"
vpc_cidr_block      = "10.0.0.0/16"
vpc_tags            = "vpc-terra-dev"
sub_az              = "eu-north-1a"
igw_tags            = "igw-terra-dev"
rt_cidr_block       = "0.0.0.0/0"
rt_tags             = "rt-terra-dev"
ec2_az              = "eu-north-1a"
ec2_inst_type       = "t3.micro"
ec2_key_name        = "sandy-pem"
public_subnet1_cidr = "10.0.1.0/24"
public_subnet2_cidr = "10.0.2.0/24"
public_subnet3_cidr = "10.0.3.0/24"
public_subnet1_name = "Terraform_Public_Subnet1-main"
public_subnet2_name = "Terraform_Public_Subnet2-main"
public_subnet3_name = "Terraform_Public_Subnet3-main"