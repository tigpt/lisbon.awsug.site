# Create the hostedzone for this city
module "route53_awsug_zone" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "~> 2.0"

  zones = {
    "lisbon.awsug.site" = {
      comment = "lisbon.awsug.site"
    }
  }
}
