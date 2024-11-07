resource "aws_vpc" "vpc-terra" {
  cidr_block           = var.vpc_cidr_block # "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"

  tags = {
    Name = var.vpc_tags #"vpc-terra"
  }
}

resource "aws_subnet" "subnet1-terra" {
  vpc_id            = aws_vpc.vpc-terra.id
  cidr_block        = var.public_subnet1_cidr
  availability_zone = var.sub_az
  tags = {
    Name = "${var.public_subnet1_name}"
  }
}

resource "aws_subnet" "subnet2-terra" {
  vpc_id            = aws_vpc.vpc-terra.id
  cidr_block        = var.public_subnet2_cidr
  availability_zone = "eu-north-1b"

  tags = {
    Name = "${var.public_subnet2_name}"
  }
}

resource "aws_subnet" "subnet3-terra" {
  vpc_id            = aws_vpc.vpc-terra.id
  cidr_block        = var.public_subnet3_cidr
  availability_zone = var.sub_az

  tags = {
    Name = "${var.public_subnet3_name}"
  }

}

resource "aws_internet_gateway" "igw-terra" {
  vpc_id = aws_vpc.vpc-terra.id

  tags = {
    Name = var.igw_tags #"igw-terra"
  }
}

resource "aws_route_table" "rt-terra" {
  vpc_id = aws_vpc.vpc-terra.id

  route {
    cidr_block = var.rt_cidr_block #"0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-terra.id
  }

  tags = {
    Name = var.rt_tags #"rt-terra"
  }
}

resource "aws_route_table_association" "rta-terra" {
  subnet_id      = aws_subnet.subnet1-terra.id
  route_table_id = aws_route_table.rt-terra.id
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc-terra.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_all"
  }
}

/*
resource "aws_s3_bucket" "sandy-preethi-00001" {
  bucket = "sandy-preet-00001"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
  #depends_on = [aws_route_table_association.rta-terra]
}

resource "aws_s3_bucket" "sandy-pree-00002" {
  bucket = "sandy-preethi-00002"

  tags = {
    Name        = "My bucket"
    Environment = "PPR"
  }
  depends_on = [aws_s3_bucket.sandy-preethi-00001]
}

resource "aws_s3_bucket" "sandy-pree-00003" {
  bucket = "sandy-preethi-00003"

  tags = {
    Name        = "My bucket"
    Environment = "PRD"
  }
  depends_on = [aws_s3_bucket.sandy-preethi-00002]
}
*/
