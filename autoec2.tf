resource "aws_autoscaling_group" "ec2-asg" {
  availability_zones = ["ap-northeast-2a"]
  desired_capacity   = 2
  min_size           = 2
  max_size           = 10


  launch_template {
    id      = "${aws_launch_template.template.id}"
    version = "$Latest"
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.ec2-asg.id
  alb_target_group_arn = aws_lb_target_group.vpc-target.arn
} 