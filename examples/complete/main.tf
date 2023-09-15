module "acm_route53" {
  source = "../../"

  create = true
  domain_names = [
    "awsref.kubecloud.net",
    "www.awsref.kubecloud.net",
  ]
  hosted_zone_name       = "kubecloud.net"
  private_zone           = false
  validation_method      = "DNS"
  allow_record_overwrite = true
  ttl                    = 60
  tags = {
    "Name" = "ssl-cert"
  }
}

# Other supporting resources
module "vpc" {
  source  = "shamimice03/vpc/aws"
  version = "1.2.1"

  create                    = true
  vpc_name                  = "dev-vpc"
  cidr                      = "192.170.0.0/16"
  azs                       = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
  public_subnet_cidr        = ["192.170.0.0/20", "192.170.16.0/20", "192.170.32.0/20"]
  enable_dns_hostnames      = true
  enable_dns_support        = true
  enable_single_nat_gateway = false

  tags = {
    "Team" = "platform-team"
    "Env"  = "dev"
  }
}

locals {
  vpc_id                       = module.vpc.vpc_id
  alb_name_prefix              = "testlb"
  alb_subnets                  = module.vpc.public_subnet_id
  alb_sgs                      = [module.alb_sg.security_group_id]
  alb_target_group_name_prefix = "testtg"
  alb_certificate_arn          = module.acm_route53.domain_certificate_arns["awsref.kubecloud.net"] #<------------
}

module "alb_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  create      = true
  vpc_id      = local.vpc_id
  name        = local.alb_name_prefix
  description = "SG for ALB"

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp"]

  egress_rules       = ["all-all"]
  egress_cidr_blocks = ["0.0.0.0/0"]
}


module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.7.0"

  create_lb          = true
  name_prefix        = local.alb_name_prefix
  load_balancer_type = "application"
  vpc_id             = local.vpc_id
  subnets            = local.alb_subnets
  security_groups    = local.alb_sgs

  target_groups = [
    {
      name_prefix      = local.alb_target_group_name_prefix
      target_type      = "instance"
      backend_port     = 80
      backend_protocol = "HTTP"
      protocol_version = "HTTP1"
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = local.alb_certificate_arn #<------------
      action_type        = "forward"
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
      action_type        = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  tags = {
    "Name" = local.alb_name_prefix
  }
}
