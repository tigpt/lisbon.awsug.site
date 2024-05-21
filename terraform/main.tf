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

  custom_rule {
    source = "/<*>"
    status = "404-200"
    target = "/index.html"
  }
}

