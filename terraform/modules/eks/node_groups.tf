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

  update_config {
    max_unavailable = var.update_max_unavailable
  }

#  tags = merge(
#    {
#      "Name" = "${var.cluster_name}-${each.key}"
#    },
#    each.value.additional_tags
#  )
}

