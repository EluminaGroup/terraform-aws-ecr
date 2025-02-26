resource "aws_ecr_lifecycle_policy" "default" {
  repository = "${aws_ecr_repository.default.name}"
  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Expire images older than 1 days",
      "selection": {
        "countUnit": "days",
        "countType": "sinceImagePushed",
        "countNumber": 1,
        "tagStatus": "untagged"
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 2,
      "description": "Expire images with feature tag",
      "selection": {
        "countType": "imageCountMoreThan",
        "tagPrefixList": [
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
        ],
        "countNumber": 1,
        "tagStatus": "tagged"
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 3,
      "description": "Keep only the 4 most recent *-prod images",
      "selection": {
        "countType": "imageCountMoreThan",
        "tagPatternList": [
          "*-prod"
        ],
        "countNumber": 4,
        "tagStatus": "tagged"
      },
      "action": {
        "type": "expire"
      }
    },
    {
      "rulePriority": 4,
      "description": "Keep only the 2 most recent *-staging images",
      "selection": {
        "countType": "imageCountMoreThan",
        "tagPatternList": [
          "*-staging",
          "*-dev"
        ],
        "countNumber": 2,
        "tagStatus": "tagged"
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}