#module "label" {
#    source     = "./modules/label"
#    namespace  = var.namespace
#    name       = var.name
#    stage      = var.stage
#    delimiter  = var.delimiter
#    attributes = var.attributes
#}

#############
#VPC Module#
#############

module "vpc" {
  source                = "./modules/vpc"
  cluster_name          = "${var.project}-${var.app_name}-${var.stage}-eks-cluster"
  create_vpc            = var.create_vpc
  vpc_name              = "${var.project}-${var.app_name}-${var.stage}-vpc"
  vpc_cidr              = var.vpc_cidr
  azs                   = var.azs
  public_subnets_cidr   = var.public_subnets_cidr
  public_subnets_ids    = var.public_subnets_ids
  private_subnets_cidr  = var.private_subnets_cidr
  private_subnets_ids   = var.private_subnets_ids
  enable_nat_vpc        = var.enable_nat_vpc
  enable_dns_support    = var.enable_dns_support
  enable_dns_hostnames  = var.enable_dns_hostnames
  additional_cidr_block = var.additional_cidr_block
  # cidr_blocks                = var.cidr_blocks
  vpc_id                  = var.vpc_id
  destination_cidr_block  = var.destination_cidr_block
  region                  = var.region
  default_tags            = var.default_tags
  map_public_ip_on_launch = var.map_public_ip_on_launch
  igw_name                = "${var.project}-${var.app_name}-${var.stage}-igw"
  nat_name                = "${var.project}-${var.app_name}-${var.stage}-nat"
}

#############
#EKS Module#
#############

module "eks-cluster" {
  source                          = "./modules/eks-cluster"
  count                           = var.create_eks-cluster ? 1 : 0
  azs                             = var.azs
  create_vpc                      = var.create_vpc
  stage                           = var.stage
  eks_iam_role_name               = "${var.project}-${var.app_name}-${var.stage}-role"
  cluster_name                    = "${var.project}-${var.app_name}-${var.stage}-eks-cluster"
  eks_cluster_version             = var.eks_cluster_version
  eks_cluster_log_types           = var.eks_cluster_log_types
  creates_cloudwatch_log_group    = var.creates_cloudwatch_log_group
  retention_days                  = var.retention_days
  cidr_blocks                     = var.cidr_blocks
  eks_vpc_id                      = module.vpc.vpc_id.0
  subnet_ids                      = module.vpc.eks_subnets
  eks_endpoint_private_access     = var.eks_endpoint_private_access
  eks_endpoint_public_access      = var.eks_endpoint_public_access
  eks_endpoint_public_access_cidr = var.eks_endpoint_public_access_cidr
  eks_workernode_iam_role_name    = "${var.project}-${var.app_name}-${var.stage}-worker-role"
  nodes_private_subnets_cidr      = var.worker_nodes_private_subnets_cidr
  nodes_private_subnets_ids       = var.worker_nodes_private_subnets_ids
  private_route_id                = module.vpc.private_route_id
  eks_cluster_node_group_name     = "${var.project}-${var.app_name}-${var.stage}-nodegroup-${lower(var.capacity_type)}-"
  dc_desired_capacity             = var.dc_desired_capacity
  be_desired_capacity             = var.dc_desired_capacity
  ami_type                        = var.ami_type
  dc_instance_type                = var.capacity_type == "SPOT" ? var.eks_instance_type_spot : var.dc_instance_type
  be_instance_type                = var.capacity_type == "SPOT" ? var.eks_instance_type_spot : var.be_instance_type
  disk_size                       = var.disk_size
  dc_max_size                     = var.dc_max_size
  dc_min_size                     = var.dc_min_size
  be_max_size                     = var.be_max_size
  be_min_size                     = var.be_min_size
  ec2_ssh_key                     = var.ec2_ssh_key
  region                          = var.region
  manage_aws_auth                 = true
  depends_on                      = [module.vpc]
  capacity_type                   = var.capacity_type
  bucket_name                     = "ssh-bas-key-s3-bucket"
  create_node_key                 = var.create_node_key
  ec2_vpc_id                      = module.vpc.vpc_id.0
  noc_cidr_blocks                 = var.noc_cidr_blocks
}

#####################
# common resources  #
#####################

module "common" {
  source                                = "./modules/common"
  namespace                             = var.namespace
  stage                                 = var.stage
  subnet_ids                            = [module.vpc.private_subnets.0, module.vpc.private_subnets.1]
  vpc_id                                = module.vpc.vpc_id.0
  tags                                  = "${var.project}-${var.app_name}-${var.stage}"
  rds_role_name                         = "RdsMonitoring-${var.project}-${var.app_name}-${var.stage}-Role"
}

#############
#RDS Module#
#############

locals {
  timestamp           = "${formatdate("DDMMMYYYY-hh-mm-ss-ZZZ", "${timestamp()}")}-5hrs30min"
  timestamp_sanitized = replace("${local.timestamp}", "/[ | |,]/", "")
  dotcmsmaster_db_password  = var.create_rds == true ? module.RDS[0].masterdbpassword : "null"
  backendmaster_db_password  = var.create_rds == true ? module.RDSBE[0].masterdbpassword : "null"
  rds_hostname        = var.create_rds == true ? module.RDS[0].rds_instance_address : "null"
  os_domain           = var.create_opensearch == true ? module.OpenSearch[0].opensearch_domain_endpoint : "null"
  filesystem_id       = var.create_efs == true ? module.EFS[0].id : "null"
}

module "RDS" {
  source                                = "./modules/rds"
  count                                 = var.create_rds ? 1 : 0
  namespace                             = var.namespace
  stage                                 = var.stage
  name                                  = var.name
  delimiter                             = var.delimiter
  tags                                  = "${var.project}-${var.app_name}-${var.stage}"
  rds_role_name                         = module.common.rds_enhanced_monitoring_role
  parameter_group_name                  = "${var.project}-${var.app_name}-${var.stage}-postgres11"
  parameter_family                      = var.parameter_family
  subnet_ids                            = [module.vpc.private_subnets.0, module.vpc.private_subnets.1]
  vpc_id                                = module.vpc.vpc_id.0
  db_name_rds                           = var.db_name_rds
  enable_special                        = var.enable_special
  override_special                      = var.override_special
  passwd_length                         = var.passwd_length
  identifier                            = "${var.project}-${var.app_name}-${var.stage}-${var.dotcms_rds_name}"
  snapshot_identifier                   = var.snapshot_identifier
  vpc_cidr                              = var.vpc_cidr
  db_subnet_group_name                  = module.common.subnet_group_id
  storage_type                          = var.storage_type
  allocated_storage                     = var.allocated_storage
  max_allocated_storage                 = var.max_allocated_storage
  db_engine                             = var.db_engine
  engine_version_db                     = var.engine_version_db
  instance_class                        = var.dotcms_instance_class
  db_username                           = var.db_username
  port                                  = var.port
  apply_immediately                     = var.apply_immediately
  backup_window                         = var.backup_window
  backup_retention_period               = var.backup_retention_period
  skip_final_snapshot                   = var.skip_final_snapshot
  final_snapshot_identifier             = "${var.project}-${var.app_name}-${var.stage}-final-snapshot-${local.timestamp}"
  deletion_protection                   = var.deletion_protection
  enabled_cloudwatch_logs_exports       = var.enabled_cloudwatch_logs_exports
  #iops                                  = var.iops
  storage_encrypted                     = var.storage_encrypted
  publicly_accessible                   = var.publicly_accessible
  multi_az                              = var.multi_az
  cpu_utilization_threshold             = var.cpu_utilization_threshold
  freeable_memory_threshold             = var.freeable_memory_threshold
  free_storage_space_threshold          = var.free_storage_space_threshold
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  parameter_settings = [
    {
      name  = "log_statement"
      value = "all"
    },
    {
      name  = "auto_explain.log_analyze"
      value = "1"
    },
    {
      name  = "auto_explain.log_buffers"
      value = "0"
    },
    {
      name  = "auto_explain.log_format"
      value = "text"
    },
    {
      name  = "auto_explain.log_min_duration"
      value = "1"
    },
    {
      name  = "auto_explain.log_nested_statements"
      value = "1"
    },
    {
      name  = "auto_explain.log_timing"
      value = "1"
    },
    {
      name  = "auto_explain.log_triggers"
      value = "0"
    },
    {
      name  = "auto_explain.log_verbose"
      value = "0"
    },
    {
      name  = "auto_explain.sample_rate"
      value = "1"
    },
    {
      name  = "rds.log_retention_period"
      value = "2880"
    },
    {
      name  = "rds.logical_replication"
      value = "1"
    },
    {
      name  = "wal_compression"
      value = "1"
    },
    {
      name  = "wal_buffers"
      value = "16MB"
    },
    {
      name  = "max_wal_size"
      value = "32GB"
    },
    {
      name  = "min_wal_size"
      value = "8GB"
    },
    {
      name  = "max_replication_slots"
      value = "20"
    }
  ]
}

module "RDSBE" {
  source                                = "./modules/rds"
  count                                 = var.create_rds ? 1 : 0
  namespace                             = var.namespace
  stage                                 = var.stage
  name                                  = var.name
  delimiter                             = var.delimiter
  tags                                  = "${var.project}-${var.app_name}-${var.stage}"
  #rds_role_name                         = "RdsMonitoring-${var.project}-${var.app_name}-${var.stage}-Role"
  rds_role_name                         = module.common.rds_enhanced_monitoring_role
  parameter_group_name                  = "${var.project}-${var.app_name}-${var.stage}-postgres11"
  parameter_family                      = var.parameter_family
  subnet_ids                            = [module.vpc.private_subnets.0, module.vpc.private_subnets.1]
  vpc_id                                = module.vpc.vpc_id.0
  db_name_rds                           = var.db_name_rds
  enable_special                        = var.enable_special
  override_special                      = var.override_special
  passwd_length                         = var.passwd_length
  identifier                            = "${var.project}-${var.app_name}-${var.stage}-${var.be_rds_name}"
  snapshot_identifier                   = var.snapshot_identifier
  vpc_cidr                              = var.vpc_cidr
  db_subnet_group_name                  = module.common.subnet_group_id
  storage_type                          = var.storage_type
  allocated_storage                     = var.allocated_storage
  max_allocated_storage                 = var.max_allocated_storage
  db_engine                             = var.db_engine
  engine_version_db                     = var.engine_version_db
  instance_class                        = var.backend_instance_class
  db_username                           = var.db_username
  port                                  = var.port
  apply_immediately                     = var.apply_immediately
  backup_window                         = var.backup_window
  backup_retention_period               = var.backup_retention_period
  skip_final_snapshot                   = var.skip_final_snapshot
  final_snapshot_identifier             = "${var.project}-${var.app_name}-${var.stage}-final-snapshot-${local.timestamp}"
  deletion_protection                   = var.deletion_protection
  enabled_cloudwatch_logs_exports       = var.enabled_cloudwatch_logs_exports
  #iops                                  = var.iops
  storage_encrypted                     = var.storage_encrypted
  publicly_accessible                   = var.publicly_accessible
  multi_az                              = var.multi_az
  cpu_utilization_threshold             = var.cpu_utilization_threshold
  freeable_memory_threshold             = var.freeable_memory_threshold
  free_storage_space_threshold          = var.free_storage_space_threshold
  performance_insights_enabled          = var.performance_insights_enabled
  performance_insights_retention_period = var.performance_insights_retention_period
  parameter_settings = [
    {
      name  = "log_statement"
      value = "all"
    },
    {
      name  = "auto_explain.log_analyze"
      value = "1"
    },
    {
      name  = "auto_explain.log_buffers"
      value = "0"
    },
    {
      name  = "auto_explain.log_format"
      value = "text"
    },
    {
      name  = "auto_explain.log_min_duration"
      value = "1"
    },
    {
      name  = "auto_explain.log_nested_statements"
      value = "1"
    },
    {
      name  = "auto_explain.log_timing"
      value = "1"
    },
    {
      name  = "auto_explain.log_triggers"
      value = "0"
    },
    {
      name  = "auto_explain.log_verbose"
      value = "0"
    },
    {
      name  = "auto_explain.sample_rate"
      value = "1"
    },
    {
      name  = "rds.log_retention_period"
      value = "2880"
    },
    {
      name  = "rds.logical_replication"
      value = "1"
    },
    {
      name  = "wal_compression"
      value = "1"
    },
    {
      name  = "wal_buffers"
      value = "16MB"
    },
    {
      name  = "max_wal_size"
      value = "32GB"
    },
    {
      name  = "min_wal_size"
      value = "8GB"
    },
    {
      name  = "max_replication_slots"
      value = "20"
    }
  ]

}


############
#EFS Module#
############

module "EFS" {
  source                              = "./modules/efs"
  count                               = var.create_efs ? 1 : 0
  enable_local                        = var.enable_local
  enable_efs_policy                   = var.enable_efs_policy
  vpc_id                              = module.vpc.vpc_id.0
  vpc_cidr                            = var.vpc_cidr
  private_subnet_ids                  = [module.vpc.private_subnets.0, module.vpc.private_subnets.1, module.vpc.private_subnets.2]
  namespace                           = var.namespace
  stage                               = var.stage
  name                                = var.name
  delimiter                           = var.delimiter
  efs_encrypted                       = var.efs_encrypted
  kms_key_id                          = var.kms_key_id
  performance_mode                    = var.performance_mode
  provisioned_throughput_in_mibps     = var.provisioned_throughput_in_mibps
  throughput_mode                     = var.throughput_mode
  transition_to_ia                    = var.transition_to_ia
  transition_to_primary_storage_class = var.transition_to_primary_storage_class
  efs_backup_policy_enabled           = var.efs_backup_policy_enabled
  bypass_policy_lockout_safety_check  = var.bypass_policy_lockout_safety_check
  path                                = var.path
}

################
#Bastion Module#
################

module "bastion" {
  source                      = "./modules/bastion"
  count                       = var.create_bastion ? 1 : 0
  ec2_instance_type           = var.ec2_instance_type
  noc_ssh_key                 = var.noc_ssh_key
  key_name                    = "${var.project}-${var.app_name}-${var.stage}-bastion-key"
  noc_cidr_blocks             = var.noc_cidr_blocks
  eks_primary_sg              = module.eks-cluster[0].sec_group
  associate_public_ip         = var.associate_public_ip
  cluster_name                = module.eks-cluster[0].cluster_name
  subnet_id                   = module.vpc.public_subnets
  root_vol_size               = var.root_vol_size
  create_noc_key              = var.create_noc_key
  bucket_name                 = "ssh-bas-key-s3-bucket"
  user_data_replace_on_change = var.user_data_replace_on_change
  bastion_sg                  = module.eks-cluster[0].bastion_sg_id
  user_data = base64encode(templatefile("./templates/noc-setup.sh",
    { CLUSTER_NAME = module.eks-cluster[0].cluster_name,
      AWS_REGION   = var.region,
      EKS_VERSION  = var.eks_cluster_version,

  }))
}



