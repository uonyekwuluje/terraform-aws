resource "aws_security_group" "app_lb_sg" {
  name = "app_sg"
  vpc_id = var.vpc_id

  ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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
    Name = "app_sg"
  }
}


resource "aws_lb_target_group" "webapp-target-group" {
  health_check {
    interval            = 50
    path                = "/"
    protocol            = "HTTP"
    timeout             = 40
    healthy_threshold   = 10
    unhealthy_threshold = 10
  }

  name        = "webapp-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id
}


resource "aws_lb" "app-elb" {
  name               = "pyelb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.public_subnet_1_id,var.public_subnet_2_id]
  security_groups    = [ aws_security_group.app_lb_sg.id ]
  ip_address_type    = "ipv4"

  tags = {
    Environment = "development"
  }
}

resource "aws_lb_listener" "app-lb-listner" {
  load_balancer_arn = aws_lb.app-elb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.webapp-target-group.arn
  }
}




data "template_file" "user_data" {
  template = file("init-scripts/user-data.tpl")
}


resource "aws_launch_configuration" "app-launch-config" {
  image_id        = var.aws_ami
  instance_type   = var.aws_type
  security_groups = [var.security_group]
  user_data_base64  = base64encode(data.template_file.user_data.rendered)

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "app_asg" {
  launch_configuration = aws_launch_configuration.app-launch-config.name
  vpc_zone_identifier  = [var.private_subnet_1_id, var.private_subnet_2_id]
  target_group_arns    = [aws_lb_target_group.webapp-target-group.arn]
  health_check_type    = "ELB"

  min_size = 2
  max_size = 4

  tag {
    key                 = "Name"
    value               = var.server_name
    propagate_at_launch = true
  }
}

