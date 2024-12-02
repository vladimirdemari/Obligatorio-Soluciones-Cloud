resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = var.role_arn

  vpc_config {
    subnet_ids                     = var.private_subnets
    security_group_ids             = [aws_security_group.cluster.id]
    endpoint_public_access         = var.cluster_endpoint_public_access
    endpoint_private_access        = var.cluster_endpoint_private_access
  }

  access_config {
    authentication_mode                         = var.authentication_mode
    bootstrap_cluster_creator_admin_permissions = false
  }

  upgrade_policy {
    support_type = var.support_type
  }
}

resource "aws_eks_access_entry" "example" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/voclabs"
  user_name     = "arn:aws:sts::${data.aws_caller_identity.current.account_id}:assumed-role/voclabs/{{SessionName}}"
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "example" {
  cluster_name  = aws_eks_cluster.this.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/voclabs"

  access_scope {
    type        = "cluster"
  }
}

