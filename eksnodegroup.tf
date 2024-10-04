resource "aws_iam_role" "eks_nodes_role" {
  name = "${local.app}-${local.env}-eks-nodes-role"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy" # This policy now includes AssumeRoleForPodIdentity for the Pod Identity Agent
  role = aws_iam_role.eks_nodes_role.name
  depends_on = [ aws_iam_role.eks_nodes_role ]
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_nodes_role.name
  depends_on = [ aws_iam_role.eks_nodes_role ]
}

resource "aws_iam_role_policy_attachment" "eks_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_nodes_role.name
  depends_on = [ aws_iam_role.eks_nodes_role ]
}

resource "aws_eks_node_group" "eks_cpu_nodes" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  node_role_arn = aws_iam_role.eks_nodes_role.arn
  subnet_ids = [ aws_subnet.private_subnet_zone1.id, aws_subnet.private_subnet_zone2.id ]
  capacity_type = "ON_DEMAND"
  instance_types = var.eks_cpu_instance
  node_group_name = "${local.app}-${local.env}-eks-cpu-node-group"

  scaling_config {
    desired_size = 1
    min_size = 0
    max_size = 10
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "general"
  }

  depends_on = [ 
    aws_iam_role_policy_attachment.eks_AmazonEKSWorkerNodePolicy, 
    aws_iam_role_policy_attachment.eks_AmazonEC2ContainerRegistryReadOnly, 
    aws_iam_role_policy_attachment.eks_AmazonEKS_CNI_Policy,
    aws_eks_cluster.eks_cluster,
    aws_subnet.private_subnet_zone1,
    aws_subnet.private_subnet_zone2
  ]

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

}