resource "aws_iam_role" "eks_cluster_role" {
  name = "${local.app}-${local.env}-eks-cluster-role"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role = aws_iam_role.eks_cluster_role.name
  depends_on = [ aws_iam_role.eks_cluster_role ]
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role = aws_iam_role.eks_cluster_role.name
  depends_on = [ aws_iam_role.eks_cluster_role ]
}

resource "aws_eks_cluster" "eks_cluster" {
  name = "${local.app}-${local.env}-eks-cluster"
  version = var.eks_version
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [ 
      aws_subnet.private_subnet_zone1.id, 
      aws_subnet.private_subnet_zone2.id,
      aws_subnet.public_subnet_zone1.id,
      aws_subnet.public_subnet_zone2.id
    ]
    endpoint_private_access = false
    endpoint_public_access = true
  }

  access_config {
    authentication_mode = "API"
    bootstrap_cluster_creator_admin_permissions = true
  }

  depends_on = [ 
    aws_iam_role_policy_attachment.eks_AmazonEKSClusterPolicy, 
    aws_iam_role_policy_attachment.eks_AmazonEKSVPCResourceController, 
    aws_subnet.private_subnet_zone1, aws_subnet.private_subnet_zone2 
  ]

  tags = {
    Name = "${local.app}-${local.env}-eks-cluster"
    Iac = "terraform"
    env = "${local.env}"
  }

}