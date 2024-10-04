resource "aws_eks_addon" "eks_coredns" {
  cluster_name                = aws_eks_cluster.eks_cluster.name
  addon_name                  = "coredns"
  addon_version               = "v1.11.3-eksbuild.1"
  resolve_conflicts_on_create = "OVERWRITE"
}

resource "aws_eks_addon" "eks_kube_proxy" {
  cluster_name                = aws_eks_cluster.eks_cluster.name
  addon_name                  = "kube-proxy"
  addon_version               = "v1.29.7-eksbuild.5"
  resolve_conflicts_on_create = "OVERWRITE"
}

resource "aws_eks_addon" "eks_vpc_cni" {
  cluster_name                = aws_eks_cluster.eks_cluster.name
  addon_name                  = "vpc-cni"
  addon_version               = "v1.18.3-eksbuild.3"
  resolve_conflicts_on_create = "OVERWRITE"
}

resource "aws_eks_addon" "eks_pod_identity" {
  cluster_name                = aws_eks_cluster.eks_cluster.name
  addon_name                  = "eks-pod-identity-agent"
  addon_version               = "v1.2.0-eksbuild.1"
  resolve_conflicts_on_create = "OVERWRITE"  
}