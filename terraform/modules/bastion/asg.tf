resource "aws_autoscaling_group" "bastion_asg" {
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size

  launch_template {
    id      = aws_launch_template.bastion.id
    version = "$Latest"
  }

  vpc_zone_identifier = var.public_subnets 

  tag {
    key                 = "Name"
    value               = "bastion"
    propagate_at_launch = true
  }
}

