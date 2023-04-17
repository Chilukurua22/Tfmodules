####### EKS Outputs #########
##---------EKS CLUSTER OUTPUTS--------###
output "cluster_id" {
  value = module.eks-cluster[*].cluster_id
}

output "cluster_endpoint" {
  value = module.eks-cluster[*].cluster_endpoint
}

output "cluster_certificate_authority_data" {
  value = module.eks-cluster[*].cluster_certificate_authority_data
}

output "kubectl_config" {
  value     = module.eks-cluster[*].kubectl_config
  sensitive = true
}

output "config_map_aws_auth" {
  value     = module.eks-cluster[*].config_map_aws_auth
  sensitive = true
}

output "cluster_name" {
  value = module.eks-cluster[*].cluster_name
}

output "cluster_iam_role_name" {
  value = module.eks-cluster[*].cluster_iam_role_name
}

output "cluster_iam_role_arn" {
  value = module.eks-cluster[*].cluster_iam_role_arn
}

output "worker_iam_role_name" {
  value = module.eks-cluster[*].worker_iam_role_name
}

output "worker_iam_role_arn" {
  value = module.eks-cluster[*].worker_iam_role_arn
}

##### VPC Outputs ######

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "nodes_private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

##### RDS Outputs ########

output "rds_instance_id" {
  value = length(module.RDS[*]) > 0 ? module.RDS[*].rds_instance_id : null
}

# Output the address (aka hostname) of the RDS instance
output "rds_instance_address" {
  value = length(module.RDS[*]) > 0 ? module.RDS[*].rds_instance_id : null
}

output "rds_instance_username" {
  value = length(module.RDS[*]) > 0 ? module.RDS[*].rds_instance_username : null
}

output "rds_instance_password" {
  value     = length(module.RDS[*]) > 0 ? module.RDS[*].rds_instance_password : null
  sensitive = true
}

output "rds_instance_version" {
  value = length(module.RDS[*]) > 0 ? module.RDS[*].rds_instance_version : null
}

# Output endpoint (hostname:port) of the RDS instance
output "dotcms_rds_instance_endpoint" {
  value = length(module.RDS[*]) > 0 ? module.RDS[*].rds_instance_endpoint : null
}

output "backend_rds_instance_endpoint" {
  value = length(module.RDSBE[*]) > 0 ? module.RDS[*].rds_instance_endpoint : null
}

# Output the ID of the Subnet Group
output "subnet_group_id" {
  value = length(module.common[*]) > 0 ? module.common[*].subnet_group_id : null
}

# Output DB security group ID
output "rds_security_group_id" {
  value = length(module.RDS[*]) > 0 ? module.RDS[*].rds_security_group_id : null
}

#Output DB Enhanced monitoring role name
output "rds_enhanced_monitoring_role" {
  value = length(module.common[*]) > 0 ? module.common[*].rds_enhanced_monitoring_role : null
}

#Masterdb Password
output "dotcmsmasterdbpassword" {
  value     = length(module.RDS[*]) > 0 ? module.RDS[*].masterdbpassword : null
  sensitive = true
}
output "backendmasterdbpassword" {
  value     = length(module.RDS[*]) > 0 ? module.RDSBE[*].masterdbpassword : null
  sensitive = true
}

#############EFS Outputs###########

output "access_point_arns" {
  value       = var.enable_local ? module.EFS[*].access_point_arns : null
  description = "EFS AP ARNs"
}

output "access_point_ids" {
  value       = var.enable_local ? module.EFS[*].access_point_ids : null
  description = "EFS AP ids"
}

output "arn" {
  value       = length(module.EFS[*]) > 0 ? module.EFS[*].arn : null
  description = "EFS ARN"
}

output "id" {
  value       = length(module.EFS[*]) > 0 ? module.EFS[*].id : null
  description = "EFS ID"
}

output "dns_name" {
  value       = length(module.EFS[*]) > 0 ? module.EFS[*].dns_name : null
  description = "EFS DNS name"
}

output "mount_target_dns_names" {
  value       = var.create_efs ? module.EFS[*].mount_target_dns_names : null
  description = "List of EFS mount target DNS names"
}

output "mount_target_ids" {
  value       = var.create_efs ? module.EFS[*].mount_target_ids : null
  description = "List of EFS mount target IDs (one per Availability Zone)"
}

output "mount_target_ips" {
  value       = var.create_efs ? module.EFS[*].mount_target_ips : null
  description = "List of EFS mount target IPs (one per Availability Zone)"
}

output "network_interface_ids" {
  value       = var.create_efs ? module.EFS[*].network_interface_ids : null
  description = "List of mount target network interface IDs"
}

######Bastion Node Outputs######

##Bastion Node id######
output "instance_id" {
  description = "Bastion Node instance ID."
  value       = module.bastion[*].instance_id
}

output "instance_arn" {
  description = "Bastion Node instance arn."
  value       = module.bastion[*].instance_arn
}

output "public_ip" {
  description = "Bastion Public IP"
  value       = module.bastion[*].public_ip
}
