
# for target group 1

resource "aws_lb_target_group" "alb-tg1" {
  name     = "alb-tg1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-379d4d5c"
}

# for target group 2
resource "aws_lb_target_group" "alb-tg2" {
  name     = "alb-tg2"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-379d4d5c"
}


resource "aws_lb_target_group_attachment" "attach-1" {
  target_group_arn = aws_lb_target_group.alb-tg1.arn
  target_id        = aws_instance.instance.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "attach-2" {
  target_group_arn = aws_lb_target_group.alb-tg2.arn
  target_id        = aws_instance.instance1.id
  port             = 80
}
