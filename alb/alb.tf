
# for alb

resource "aws_lb" "alb-11" {
  name               = "alb-11"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg1.id]
  subnets            = ["subnet-76718f1d","subnet-32e5ca7e"]

  # enable_deletion_protection = true

  tags = {
    Name = "alb-11"
  }
}

# for default listener

resource "aws_lb_listener" "l-1" {
  load_balancer_arn = aws_lb.alb-11.arn
  port              = "80"
  protocol          = "HTTP"
  # ssl_policy        = "ELBSecurityPolicy-2016-08"
  # certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg1.arn
  }
}


# for listener rule 1

resource "aws_lb_listener_rule" "lr1" {
  listener_arn = aws_lb_listener.l-1.arn
  # priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg1.arn
  }

  condition {
    path_pattern {
      values = ["/chess/*"]
    }
  }
}

# for listener rule 2

resource "aws_lb_listener_rule" "lr2" {
  listener_arn = aws_lb_listener.l-1.arn
  # priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg2.arn
  }

  condition {
    path_pattern {
      values = ["/sudoku/*"]
    }
  }
}
