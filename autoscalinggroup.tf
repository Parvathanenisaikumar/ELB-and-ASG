resource "aws_autoscaling_group" "asg" {
  name = "terraform-asg"
  launch_template {
    id = aws_launch_template.template.id
  }
  min_size            = 2
  max_size            = 4
  desired_capacity    = 3
  health_check_type   = "EC2"
  vpc_zone_identifier = [aws_subnet.subnet_one.id, aws_subnet.subnet_two.id]
  load_balancers      = [aws_elb.lb.id]
}


