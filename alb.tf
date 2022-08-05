resource "aws_lb" "alb-terra" {
  name               = "alb-terra"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.vpc-securitygroup.id]
  subnets            = [aws_subnet.public.id,aws_subnet.public.id,aws_subnet.public.id,aws_subnet.public2.id]

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "vpc-tg" {
  name     = "vpc-tg"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = aws_vpc.terra-vpc.id
}

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.vpc-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.vpc-tg.arn
  }
}