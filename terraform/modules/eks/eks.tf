resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = var.node_role_arn

  vpc_config {
    subnet_ids                     = var.private_subnets
    endpoint_public_access         = var.cluster_endpoint_public_access
    endpoint_private_access        = var.cluster_endpoint_private_access
  }
}

# Cluster Add-ons
resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "coredns"
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "kube-proxy"
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "vpc-cni"
}

resource "aws_eks_addon" "eks_pod_identity_agent" {
  cluster_name = aws_eks_cluster.this.name
  addon_name   = "eks-pod-identity-agent"
}

# Managed Node Groups
resource "aws_eks_node_group" "managed" {
  for_each = var.eks_managed_node_groups

  cluster_name    = aws_eks_cluster.this.name
  node_group_name = each.key
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.private_subnets

  scaling_config {
    desired_size = each.value.desired_capacity
    min_size     = each.value.min_size
    max_size     = each.value.max_size
  }

  instance_types = var.eks_managed_node_group_defaults.instance_types
  ami_type       = each.value.ami_type

#  tags = merge(
#    {
#      "Name" = "${var.cluster_name}-${each.key}"
#    },
#    each.value.additional_tags
#  )
}

