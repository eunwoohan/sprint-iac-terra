resource "aws_launch_template" "template" {
  name = "ec2-public"

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 8
    }
  }

  ebs_optimized = false

  key_name = "practice"

  image_id = data.aws_ami.ubuntu.id

  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = true
    subnet_id = aws_subnet.public.id
    security_groups = [aws_security_group.vpc-securitygroup.id]
  }

  placement {
    availability_zone = "ap-northeast-2a"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ec2-public"
    }
  }

  user_data = filebase64("./user_data.sh")
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["365730553675"] # Canonical
} 