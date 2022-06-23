#Load Balancers
# Application Load Balancer
resource "aws_lb" "weblb" {
  name               = "WSC-WebLB"
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.weblb.id}"]
  subnets            = ["${aws_subnet.web.*.id}"]
  tags {
    Name = "WSC-WebLB"
  }
}

# Load Balancer Target Group
resource "aws_lb_target_group" "weblb_group" {
  name     = "WSC-WebLB-Group"
  port     = "${var.tg_port}"
  protocol = "${var.tg_protocol}"
  vpc_id   = "${aws_vpc.main.id}"
}

# Listeners
resource "aws_lb_listener" "webserver-lb" {
  load_balancer_arn = "${aws_lb.weblb.arn}"
  port              = "${var.listener_port}"
  protocol          = "${var.listener_protocol}"
  # certificate_arn  = "${var.certificate_arn_user}"
  default_action {
    target_group_arn = "${aws_lb_target_group.weblb_group.arn}"
    type             = "forward"
  }
}

#Listener rules
resource "aws_lb_listener_rule" "allow_all" {
  listener_arn = "${aws_lb_listener.webserver-lb.arn}"
  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.weblb_group.arn}"
  }
  condition {
    field  = "path-pattern"
    values = ["*"]
  }
}
