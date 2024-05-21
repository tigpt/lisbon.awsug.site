resource "aws_amplify_app" "lisbon" {
  name       = "lisbon.awsug.site"
  repository = "https://github.com/tigpt/lisbon.awsug.site"

  # The default build_spec added by the Amplify Console for React.
  build_spec = <<-EOT
    version: 1
    frontend:
        phases:
            build:
                commands:
                    - hugo
        artifacts:
            baseDirectory: public
            files:
                - '**/*'
        cache:
            paths: []
EOT

  # default configs for Hugo
  custom_rule {
    source = "/<*>"
    status = "404-200"
    target = "/index.html"
  }
}

resource "aws_amplify_branch" "main-branch" {
  app_id            = aws_amplify_app.lisbon.id
  branch_name       = "main"
  enable_auto_build = true
  framework         = "Web"
  stage             = "PRODUCTION"
}

#associate pagai.me domain with the amplify app.
resource "aws_amplify_domain_association" "lisbon_awsug" {
  app_id      = aws_amplify_app.lisbon.id
  domain_name = "awsug.site"

  # https://lisbon.awsug.site
  sub_domain {
    branch_name = aws_amplify_branch.main-branch.branch_name
    prefix      = "lisbon"
  }
}

# WIP:
# terraform for amplify custom domain to main branch

# TODO:
# terraform for ACM
# terraform for route53
