#### Global Variables ####
variable "region" {
}
variable "aws_profile" {
  default = "test"
}

variable "project" {
}
variable "app_name" {
}

variable "azs" {
  description = "Availabilty zones in which resources to be deployed."
}

######### Bastion variables #################
variable "create_bastion" {
  default     = true
  description = "Condition to create bastion host"
}

variable "ec2_instance_type" {
  description = "ec2 instance type"
}

variable "noc_ssh_key" {
  default = "test"
}

variable "user_data_replace_on_change" {
  type        = string
  description = "True to replace instance default false."
}

variable "associate_public_ip" {
  default = true
}

variable "noc_cidr_blocks" {
  default = ["0.0.0.0/0"]
}

variable "root_vol_size" {
  default = "20"
}

variable "create_noc_key" {
  default = false
}

######### EKS Cluster Variables #############
variable "create_eks-cluster" {
  description = "True to create EKS cluster"
}
variable "creates_cloudwatch_log_group" {
}

variable "eks_cluster_version" {
}

variable "eks_cluster_log_types" {
}

variable "retention_days" {
  default = 7
}

variable "eks_endpoint_private_access" {
  default = true
}

variable "eks_endpoint_public_access" {
  default = false
}

variable "eks_endpoint_public_access_cidr" {
  default = ["0.0.0.0/0"]
}

variable "worker_nodes_private_subnets_cidr" {
  default = []
}

variable "worker_nodes_private_subnets_ids" {
  default = []
}

variable "be_desired_capacity" {
  description = "Desired node capacity"
  default     = 2
}

variable "dc_desired_capacity" {
  description = "Desired node capacity"
  default     = 2
}

variable "dc_instance_type" {
  description = "EKS Instance type"
}

variable "be_instance_type" {
  description = "EKS Instance type"
}

variable "disk_size" {
  description = "EKS Instance disk size"
}

variable "ami_type" {
  description = "EKS Instance AMI"
}

variable "dc_max_size" {
  description = "EKS Node group max size"
}

variable "dc_min_size" {
  description = "EKS Instance min size"
}

variable "be_max_size" {
  description = "EKS Node group max size"
}

variable "be_min_size" {
  description = "EKS Instance min size"
}

variable "ec2_ssh_key" {
  default = "test"
}

variable "capacity_type" {
  type        = string
  description = "EKS Node Group instance type Accepted value:- ON_DEMAND , SPOT"
}

variable "eks_instance_type_spot" {
  description = "EKS list instance type to be definded when capacity_type is SPOT"
}

variable "create_node_key" {
  default = true
}
##### VPC Variables ####
###-----VPC VARIABLES-----####
variable "create_vpc" {
  default = true
}
variable "vpc_id" {
  default = ""
}

variable "vpc_cidr" {
  description = "VPC Cidr block"
}

variable "cidr_blocks" {
  description = "CIDR Blocks to be passed in different security groups"
  default     = ["10.0.0.0/16", "0.0.0.0/0"]
}

variable "public_subnets_cidr" {
}
variable "public_subnets_ids" {
  default = ""
}
variable "private_subnets_cidr" {
  default = ["10.0.4.0/24"]
}
variable "private_subnets_ids" {
}
variable "destination_cidr_block" {
}
variable "enable_dns_support" {

}
variable "enable_dns_hostnames" {

}
variable "enable_nat_vpc" {

}

variable "additional_cidr_block" {
}

variable "default_tags" {
}

variable "map_public_ip_on_launch" {
  default = false
}

variable "igw_name" {
}

variable "nat_name" {
}
###Label Variables####
variable "namespace" {
  type        = string
  description = "a unique identifier for your environment"
}

variable "stage" {
  type        = string
  description = "Stage, e.g. 'prod', 'staging', 'dev', or 'test'"
}

variable "name" {
  type        = string
  description = "Solution name, e.g. 'app' or 'cluster'"
  default     = ""
}
variable "delimiter" {
  type        = string
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}
variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "create_rds" {
  type        = bool
  description = "Condition for creating RDS resources"
}

variable "enable_special" {
  type        = bool
  description = "True to enable of adding special char while generating random password."
}

variable "override_special" {
  description = "Special characters that you want to use."
}

variable "passwd_length" {
  type        = number
  description = "Database password length"
}

variable "parameter_family" {
  type        = string
  description = "parameter family"
  default     = "postgres13"
}

variable "db_name_rds" {
  description = "Name of the database"
}

variable "storage_type" {
  description = "Storage type gp2 or iops Default id io1 if the IOPS is defined "
}

#variable "iops" {
# description = "IOPS speed"
#}

variable "allocated_storage" {
  description = "storage per db instance for iops min storage is 100 GB and gp2 is 20 GB"
}

variable "max_allocated_storage" {
  description = "max allocated storage to enable autoscalling in RDS instances"
}

variable "db_engine" {
  description = "name of the db engine"
}

variable "engine_version_db" {
  description = "The databse engine version"
}

variable "test_instance_class" {
  description = "Type of database"
}

variable "backend_instance_class" {
  description = "Type of database"
}

variable "test_rds_name" {
description = "database name"
}

variable "be_rds_name" {
description = "database name"
}
variable "db_username" {
  description = "Database username"
}

variable "apply_immediately" {
  description = "True to apply all the changes immediately"
}

variable "backup_window" {
  description = "Backup Window default '20:00-21:00'"
}

variable "backup_retention_period" {
  description = "backup retention period By default is 7 days"
}

variable "skip_final_snapshot" {
  description = "False to enable final shapshot on deletion"
}

variable "deletion_protection" {
  description = "Deletion Protection"
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "enabled cloudwatch logs exports"
}

variable "storage_encrypted" {
  type        = bool
  description = "storage encrypted"
}

variable "publicly_accessible" {
  type        = bool
  description = "Enable publicly accessiblity"
  default     = false
}

variable "multi_az" {
  type        = bool
  description = "Enable multi az"
}

variable "cpu_utilization_threshold" {
  description = "CPU Utilization Threshold"
}

variable "freeable_memory_threshold" {
  description = "Freeable Memory Threshold"
}

variable "free_storage_space_threshold" {
  description = "Free Storage Space Threshold"
}

variable "snapshot_identifier" {
  description = "Snapshot identifier to be restored (Default value = empty)"
}

variable "port" {
  description = "Databse port"
}
/*
variable "identifier" {
  description = "RDS identifier"
}
*/

variable "performance_insights_enabled" {
  type        = bool
  description = "True toenable performance insights."
}

variable "performance_insights_retention_period" {
  type        = string
  description = "The amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years). When specifying performance_insights_retention_period, performance_insights_enabled needs to be set to true. Defaults to '7'."
}

##OpenSearch##

variable "create_opensearch" {
  description = "True to create opensearch cluster"
  type        = bool
}

variable "opensearch_engine_version" {
  description = "OpenSearch Engine Version"
}
variable "opensearch_instance_type" {
  description = "OpenSearch instance type."
}
variable "opensearch_instance_count" {
  description = "OpenSearch Instance count"
}
variable "zone_awareness_enabled" {
  description = "True to enable multi-AZ deployment and false to diacable multi-az deployment"
  type        = bool
}
variable "availability_zone_count" {
  description = "Availablity zone count when Multi AZ enabled."
}
variable "enforce_https" {
  description = "True to enforece https connection on URL."
  type        = bool
}
variable "tls_security_policy" {
  description = "TLS Security policy version to enable https"
}
variable "encrypt_at_rest" {
  description = "True to enable encryption at rest"
  type        = bool
}
variable "node_to_node_encryption" {
  description = "True to enable node to node encryption"
  type        = bool
}
variable "ebs_enabled" {
  description = "True to enable ebs"
  type        = bool
}
variable "ebs_volume_size" {
  description = "EBS volume size"
}
variable "volume_type" {
  description = "EBS volume type Ex:- gp2"
}
variable "create_iam_service_linked_role" {
  type        = bool
  description = "Whether to create `AWSServiceRoleForAmazonElasticsearchService` service-linked role. Set it to `false` if you already have an ElasticSearch cluster created in the AWS account and AWSServiceRoleForAmazonElasticsearchService already exists. See https://github.com/terraform-providers/terraform-provider-aws/issues/5218 for more info"
}
variable "master_user_name" {
  description = "master user name"
}
variable "advanced_sg_enabled" {
  description = "enable advanced security"
  type        = bool
}
variable "internal_user_database_enabled" {
  description = "Enable internal database user"
  type        = bool
}
variable "os_enable_special" {
  type        = bool
  description = "True to enable of adding special char while generating random password."
}

variable "os_override_special" {
  description = "Special characters that you want to use."
}

variable "os_passwd_length" {
  type        = number
  description = "Database password length"
}

##EFS##

variable "create_efs" {
  description = "True to create EFS"
  type        = bool
  default     = true
}

variable "efs_encrypted" {
  type        = bool
  description = "If true, the file system will be encrypted"
}

variable "kms_key_id" {
  type        = string
  description = "If set, use a specific KMS key"
  default     = null
}

variable "performance_mode" {
  type        = string
  description = "The file system performance mode. Can be either `generalPurpose` or `maxIO`"
  default     = "maxIO"
}

variable "provisioned_throughput_in_mibps" {
  type        = number
  default     = 0
  description = "The throughput, measured in MiB/s, that you want to provision for the file system. Only applicable with `throughput_mode` set to provisioned"
}

variable "throughput_mode" {
  type        = string
  description = "Throughput mode for the file system. Defaults to bursting. Valid values: `bursting`, `provisioned`. When using `provisioned`, also set `provisioned_throughput_in_mibps`"
  default     = "bursting"
}

variable "transition_to_ia" {
  type        = list(string)
  description = "Indicates how long it takes to transition files to the Infrequent Access (IA) storage class. Valid values: AFTER_7_DAYS, AFTER_14_DAYS, AFTER_30_DAYS, AFTER_60_DAYS and AFTER_90_DAYS. Default (no value) means \"never\"."
  default     = []
  validation {
    condition = (
      length(var.transition_to_ia) == 1 ? contains(["AFTER_7_DAYS", "AFTER_14_DAYS", "AFTER_30_DAYS", "AFTER_60_DAYS", "AFTER_90_DAYS"], var.transition_to_ia[0]) : length(var.transition_to_ia) == 0
    )
    error_message = "Var `transition_to_ia` must either be empty list or one of \"AFTER_7_DAYS\", \"AFTER_14_DAYS\", \"AFTER_30_DAYS\", \"AFTER_60_DAYS\", \"AFTER_90_DAYS\"."
  }
}

variable "transition_to_primary_storage_class" {
  type        = list(string)
  description = "Describes the policy used to transition a file from Infrequent Access (IA) storage to primary storage. Valid values: AFTER_1_ACCESS."
  default     = []
  validation {
    condition = (
      length(var.transition_to_primary_storage_class) == 1 ? contains(["AFTER_1_ACCESS"], var.transition_to_primary_storage_class[0]) : length(var.transition_to_primary_storage_class) == 0
    )
    error_message = "Var `transition_to_primary_storage_class` must either be empty list or \"AFTER_1_ACCESS\"."
  }
}

variable "bypass_policy_lockout_safety_check" {
  description = "A flag to indicate whether to bypass the aws_efs_file_system_policy lockout safety check."
  type        = bool
  default     = true
}

variable "efs_backup_policy_enabled" {
  type        = bool
  description = "If `true`, it will turn on automatic backups."
  default     = false
}

variable "enable_local" {
  description = "True to enable locals block. The local block uid, gid & secondary_ids formatting, so if creating true to enable this."
  default     = false
}

variable "enable_efs_policy" {
  description = "True to enable efs policy."
  default     = false
}

variable "path" {
  description = "Access Points Path"
  type        = string
  default     = ""
}

variable "access_points" {
  type        = map(map(map(any)))
  description = <<-EOT
    A map of the access points you would like in your EFS volume
    All keys are strings. The primary keys are the names of access points.
    The secondary keys are `posix_user` and `creation_info`.
    The secondary_gids key should be a comma separated value.
    More information can be found in the terraform resource [efs_access_point](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/efs_access_point).
    EOT
  default = {
    "data" = {
      posix_user = {
        gid            = "1001"
        uid            = "5000"
        secondary_gids = "1002,1003"
      }
      creation_info = {
        gid         = "1001"
        uid         = "5000"
        permissions = "0755"
      }
    }
  }
}





