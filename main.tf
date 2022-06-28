resource "aws_eks_cluster" "eks_cluster" {
	name     = var.tags.Name
	role_arn = var.role_arn
	vpc_config {
		subnet_ids         = var.subnet_ids
		security_group_ids = var.security_group_ids
	}
	tags = var.tags
}

# output "cluster_vpc_config" {
#   value = aws_eks_cluster.eks_cluster.vpc_config
# }

# module "security_group_rule" {
# 	source = "../VPC/SECURITY_GROUP/SECURITY_GROUP_RULE"
# 	count  = length(var.security_groups_rules)
# 	security_group_id = aws_eks_cluster.eks_cluster.vpc_config[0]
# 	cidr_block        = var.security_groups_rules[count.index].cidr_block
# 	description       = var.security_groups_rules[count.index].description
# 	from_port         = var.security_groups_rules[count.index].from_port
# 	to_port           = var.security_groups_rules[count.index].to_port
# 	protocol          = var.security_groups_rules[count.index].protocol
# 	type              = var.security_groups_rules[count.index].type
# }

module "node_group" {
	source          = "./EKS_NODE_GROUP"
	count           = length(var.node_groups)
	# PJB: should node_group_name be used for reference when placing images/containers into node_groups
#	node_group_name = "${var.tags.Name}-${count.index}"
	node_group_name = var.node_group_names[count.index]
	node_role_arn   = var.node_role_arn
	cluster_name    = aws_eks_cluster.eks_cluster.name
	subnet_ids      = var.subnet_ids
	instance_types  = try(var.node_groups[count.index].instance_types, null)
	desired_size    = var.node_groups[count.index].desired_size
	min_size        = var.node_groups[count.index].min_size
	max_size        = var.node_groups[count.index].max_size
#	tags            = merge(tomap(var.tags), { Name = "${var.tags.Name}-${count.index}" })
	tags            = merge(tomap(var.tags), { Name = var.node_group_names[count.index] })
}