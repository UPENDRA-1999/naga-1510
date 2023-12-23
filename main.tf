resource "aws_s3_bucket" "dev-private-hcl-v1" {
  bucket = "dev-private-hcl-v1"
  tags = {
    Name        = "upbucket"
    Environment = "production"
  }
}


resource "aws_s3_bucket_public_access_block" "dev-private-hcl-v1" {
  bucket                  = aws_s3_bucket.dev-private-hcl-v1.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}


resource "aws_s3_bucket_versioning" "dev-private-hcl-v1" {
  bucket = aws_s3_bucket.dev-private-hcl-v1.id
  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_subnets" "selected_subnets" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }

  filter {
    name   = "subnet-id"
    values = [var.subnet_id_1, var.subnet_id_2]
  }
}

resource "aws_launch_template" "asg_ec2_template" {
  name                   = var.environment
  image_id               = var.instance_ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.guidesoft_security_group.id]
  user_data              = filebase64("script.sh")

  tags = {
    name = "guidesoft_instance"
  }
}

resource "aws_autoscaling_group" "guidesoft-sg" {
  name                = var.environment
  vpc_zone_identifier = data.aws_subnets.selected_subnets.ids
  desired_capacity    = 2
  min_size            = 2
  max_size            = 5
  tag {
    key                 = "Name"
    value               = "guidesoft-foster"
    propagate_at_launch = true
  }
  launch_template {
    id      = aws_launch_template.asg_ec2_template.id
    version = aws_launch_template.asg_ec2_template.latest_version
  }
}

resource "aws_security_group" "guidesoft_security_group" {
  name        = "guidesoft_security_group"
  description = "Allow web traffice"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow port 443"
    from_port   = 443
    to_port     = 443
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
    Name = var.environment
  }
}

