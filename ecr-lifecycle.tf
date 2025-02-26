data "aws_ecr_lifecycle_policy_document" "default" {
  rule {
    priority = 1
    description   = "Expire images older than 1 day"
    selection {
      count_unit   = "days"
      count_type   = "sinceImagePushed"
      count_number = 1
      tag_status   = "untagged"
    }
    action {
      type = "expire"
    }
  }

  rule {
    priority = 2
    description   = "Expire images with specific tags"
    selection {
      count_type     = "imageCountMoreThan"
      tag_prefix_list = [
        "feature",
        "prod",
        "deploy",
        "qa",
        "nonprod",
        "staging",
        "preprod",
        "dev",
        "test",
        "production"
      ]
      count_number  = 1
      tag_status    = "tagged"
    }
    action {
      type = "expire"
    }
  }

  rule {
    priority = 3
    description   = "Keep only the 4 most recent *-prod images"
    selection {
      count_type     = "imageCountMoreThan"
      tag_pattern_list = [
        "*-prod"       # Matches tags ending with "-prod"
      ]
      count_number  = 4
      tag_status    = "tagged"
    }
    action {
      type = "expire"
    }
  }

  rule {
    priority = 4
    description   = "Keep only the 2 most recent *-staging images"
    selection {
      count_type     = "imageCountMoreThan"
      tag_pattern_list = [
        "*-staging"    # Matches tags ending with "-staging"
      ]
      count_number  = 2
      tag_status    = "tagged"
    }
    action {
      type = "expire"
    }
  }

  rule {
    priority = 5
    description   = "Keep only the 2 most recent *-dev images"
    selection {
      count_type     = "imageCountMoreThan"
      tag_pattern_list = [
        "*-dev"        # Matches tags ending with "-dev"
      ]
      count_number  = 2
      tag_status    = "tagged"
    }
    action {
      type = "expire"
    }
  }
}

resource "aws_ecr_lifecycle_policy" "default" {
  repository = aws_ecr_repository.default.name
  policy     = data.aws_ecr_lifecycle_policy_document.default.json
}
