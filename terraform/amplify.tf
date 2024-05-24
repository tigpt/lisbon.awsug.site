resource "aws_amplify_app" "city" {
  name       = "${local.city}.awsug.site"
  repository = local.repository

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

  custom_rule {
    source = "/<*>"
    status = "404-200"
    target = "/index.html"
  }
}

resource "aws_amplify_branch" "main-branch" {
  app_id            = aws_amplify_app.city.id
  branch_name       = "main"
  enable_auto_build = true
  framework         = "Web"
  stage             = "PRODUCTION"
}

resource "aws_amplify_domain_association" "city" {
  app_id                = aws_amplify_app.city.id
  domain_name           = "${local.city}.awsug.site"
  wait_for_verification = false

  sub_domain {
    branch_name = aws_amplify_branch.main-branch.branch_name
    prefix      = ""
  }
}
