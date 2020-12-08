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
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
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


resource "aws_lb_target_group_attachment" "app-lb-target-group-attachment" {
  count            = var.node_count
  target_group_arn = aws_lb_target_group.webapp-target-group.arn
  target_id        = element(aws_instance.linux_instance.*.id, count.index)
  port             = 80
}
