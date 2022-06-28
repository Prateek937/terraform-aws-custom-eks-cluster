resource "aws_eks_node_group" "eks_node_group" {
	node_group_name = var.node_group_name
	node_role_arn   = var.node_role_arn 
	cluster_name    = var.cluster_name
	subnet_ids      = var.subnet_ids
	instance_types  = try(var.instance_types, null) 
	scaling_config {
		desired_size   = var.desired_size
		max_size       = var.max_size
		min_size       = var.min_size
	}

	tags = var.tags
}