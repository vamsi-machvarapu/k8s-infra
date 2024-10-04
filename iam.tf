/*data "aws_caller_identity" "current" {}

resource "aws_iam_role" "devops_eks_admin_role" {
  name = "devops-eks-admin-role"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_policy" "devops_eks_admin_policy" {
  policy = <<POLICY
  {
    
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Action": [
                "eks:*",
                "eks:DescribeCluster",
                "eks:ListClusters"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:PassedToService": "eks.amazonaws.com"
                }
            }
        }
    ]
  }
  POLICY  
}

resource "aws_iam_policy_attachment" "eks_admin_policy" {
  name = aws_iam_role.devops_eks_admin_role.name
  policy_arn = aws_iam_policy.devops_eks_admin_policy.arn
  roles = [aws_iam_role.devops_eks_admin_role.name]
}

resource "aws_iam_user" "devops_admin" {
  name = "devops-admin"
}

resource "aws_iam_policy" "devops_assume_eks_admin_policy" {
  policy = <<POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Statement1",
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Resource": "${aws_iam_role.devops_eks_admin_role.arn}"
        }
    ]
  }
  POLICY
}

resource "aws_iam_policy_attachment" "eks_policy_attach" {
  name = aws_iam_user.devops_admin.name
  policy_arn = aws_iam_policy.devops_assume_eks_admin_policy.arn
  roles = [aws_iam_role.devops_eks_admin_role.name]
}

resource "aws_eks_access_entry" "devops_admin" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  principal_arn = aws_iam_role.devops_eks_admin_role.arn
  kubernetes_groups = ["devops"]
}*/