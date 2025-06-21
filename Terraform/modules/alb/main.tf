# ######################################
# #  Application Load Balancer  (ALB)
# ######################################

# # ALB to expose the app server to public traffic
# resource "aws_lb" "app_lb" {
#   name               = "${var.prefix}app-alb"
#   internal           = false                      # Internet-facing
#   load_balancer_type = "application"
#   security_groups    = [var.app_sg_id]
#   subnets            = var.public_subnet_ids

#   tags = {
#     Name = "NodeJS App Load Balancer"
#   }
# }


# ######################################
# #  Target Groups For the EC2 Instances
# ######################################

# # Target Group for App EC2 instance(s)
# resource "aws_lb_target_group" "app_tg" {
#   name     = "${var.prefix}app-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = var.vpc_id

#   health_check {
#     path                = "/"     # Health check endpoint
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#   }

#   tags = {
#     Name = "${var.prefix}app-tg"
#   }
# }

# # Listener for incoming HTTP requests on port 80
# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.app_lb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.app_tg.arn
#   }
# }

# # Register each target EC2 instance to the target group
# resource "aws_lb_target_group_attachment" "app" {
#   for_each = var.target_instance_ids

#   target_group_arn = aws_lb_target_group.app_tg.arn
#   target_id        = each.value
#   port             = 80
# }

# =================================================================================

# resource "aws_lb" "app_lb" {
#   name               = "${var.prefix}-app-alb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.alb_sg.id]
#   subnets            = var.public_subnet_ids

#   tags = { Name = "${var.prefix}-app-alb" }
# }

# resource "aws_lb_target_group" "app_tg" {
#   name     = "${var.prefix}-app-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = var.vpc_id

#   health_check {
#     path                = "/"
#     interval            = 30
#     timeout             = 5
#     healthy_threshold   = 2
#     unhealthy_threshold = 2
#   }

#   tags = { Name = "${var.prefix}-app-tg" }
# }

# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.app_lb.arn
#   port              = 80
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.app_tg.arn
#   }
# }

# resource "aws_lb_target_group_attachment" "app" {
#   for_each         = toset(var.target_instance_ids)
#   target_group_arn = aws_lb_target_group.app_tg.arn
#   target_id        = each.value
#   port             = 80
# }




# =========================================================
resource "aws_lb" "app_lb" {
  name               = "${var.prefix}-app-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups = [var.alb_sg_id]
}
resource "aws_lb_target_group" "app_tg" {
  name     = "${var.prefix}-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "app" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = var.target_instance_id  # single instance ID ( app ec2 )
  port             = 80
}


