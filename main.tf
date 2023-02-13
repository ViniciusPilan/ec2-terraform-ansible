# AWS Access Config
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}


# S3 ------------------------------------------------------------------------------------------------
resource "aws_s3_bucket" "bucket_web_server" {
  bucket = var.bucket_name
  tags = {
    Name = "Bucket para a Instancia EC2 web-server"
  }
}

resource "aws_s3_bucket_policy" "allow_access_to_images" {
  bucket = aws_s3_bucket.bucket_web_server.id
  policy = data.aws_iam_policy_document.allow_access_to_images.json
}

data "aws_iam_policy_document" "allow_access_to_images" {
  statement {
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      aws_s3_bucket.bucket_web_server.arn,
      "${aws_s3_bucket.bucket_web_server.arn}/*",
    ]
  }
}


# EC2 ------------------------------------------------------------------------------------------------
resource "aws_key_pair" "key" {
  key_name   = var.key
  public_key = file("${var.key_path}/${var.key}.pub")
}


## Web-server configs --------------------------------------------------------------------------------
resource "aws_security_group" "ws_sg" {
  name        = "web-server-sg"
  description = "SSH e HTTP para o Web server"
  vpc_id      = "vpc-09855d8bef1576d80"

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.lb_eip.public_ip}/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "web-server-sg"
  }
}

resource "aws_eip" "ws_1_eip" {
  instance = aws_instance.web_server_1.id
  vpc      = true
  tags = {
    Name = "Web-server-1-eip"
  }
}

resource "aws_eip" "ws_2_eip" {
  instance = aws_instance.web_server_2.id
  vpc      = true
    tags = {
    Name = "Web-server-2-eip"
  }
}

resource "aws_instance" "web_server_1" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key
  security_groups = [aws_security_group.ws_sg.name]

  tags = {
    Name = "web-server-1"
  }
}

resource "aws_instance" "web_server_2" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key
  security_groups = [aws_security_group.ws_sg.name]

  tags = {
    Name = "web-server-2"
  }
}

## Load-balancer configs -----------------------------------------------------------------------------
resource "aws_security_group" "lb_sg" {
  name        = "load-balancer-sg"
  description = "SSH e HTTP para o Load Balancer"
  vpc_id      = "vpc-09855d8bef1576d80"

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "load-balancer-sg"
  }
}

resource "aws_eip" "lb_eip" {
  instance = aws_instance.load_balancer.id
  vpc      = true
    tags = {
    Name = "Load-balancer-eip"
  }
}

resource "aws_instance" "load_balancer" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key
  security_groups = [aws_security_group.lb_sg.name]

  tags = {
    Name = "load-balancer"
  }
}

