#### Global Values ######
#stage = "dev"
#project  = "ppbet"
app_name = "cms"
region   = "eu-west-1"
azs      = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
dotcms_rds_name = "dotcms"
be_rds_name     = "backend"

##### EKS Cluster Variables ##############
create_eks-cluster                = true
creates_cloudwatch_log_group      = true
eks_cluster_version               = "1.23"
eks_cluster_log_types             = ["api", "audit"]
retention_days                    = 7
eks_endpoint_private_access       = true
eks_endpoint_public_access        = true
eks_endpoint_public_access_cidr   = ["0.0.0.0/0"]
dc_desired_capacity               = 3
dc_max_size                       = 3
dc_min_size                       = 3
be_desired_capacity               = 6
be_max_size                       = 6
be_min_size                       = 3
dc_instance_type                  = ["t3.xlarge"]
be_instance_type                  = ["m5.xlarge"]
eks_instance_type_spot            = ["t3.xlarge", "t3a.xlarge", "t3.xlarge"]
ami_type                          = "AL2_x86_64"
disk_size                         = 20
worker_nodes_private_subnets_cidr = ["10.30.8.0/21", "10.30.16.0/21", "10.30.24.0/21"]
cidr_blocks                       = ["10.30.0.0/16"]
capacity_type                     = "SPOT"


###-------------Controller EKS Cluster VPC Variables----------------###
## If using existing VPC set this value to false and update the below values.
create_vpc = true
## If create_vpc is false, update this value with VPC ID for the existing VPC to host the controller EKS cluster
vpc_cidr             = "10.30.0.0/16"
enable_dns_support   = true
enable_dns_hostnames = true
## (Optional) Enter the list of public subnet IDs to use for either worker nodes or public endpoints of other AWS services
# Ex: ["subnet-00690d776377b1ad7", "subnet-0aaf3e0a7c9212921", "subnet-0c572b5b56372c381"]
private_subnets_cidr    = ["10.30.0.0/24", "10.30.1.0/24", "10.30.2.0/24"]
public_subnets_cidr     = ["10.30.3.0/24", "10.30.4.0/24", "10.30.5.0/24"]
additional_cidr_block   = []
default_tags            = ""
map_public_ip_on_launch = true
enable_nat_vpc          = true
public_subnets_ids      = ""
destination_cidr_block  = "0.0.0.0/0"
igw_name                = ""
nat_name                = ""
private_subnets_ids     = ""

#########  RDS Variables ##########
create_rds                            = true
enable_special                        = true
override_special                      = "^();:$~=+-_.?"
passwd_length                         = 12
parameter_family                      = "postgres12"
db_name_rds                           = "postgres"
storage_type                          = "gp2"
#iops                                 = 1000
allocated_storage                     = 100
max_allocated_storage                 = 200
db_engine                             = "postgres"
engine_version_db                     = 12.11
dotcms_instance_class                 = "db.m5.xlarge"
backend_instance_class                = "db.m5.large"
db_username                           = "postgres"
apply_immediately                     = true
backup_window                         = "20:00-21:00"
backup_retention_period               = 7
skip_final_snapshot                   = false
deletion_protection                   = false
enabled_cloudwatch_logs_exports       = ["postgresql"]
storage_encrypted                     = false
publicly_accessible                   = false
multi_az                              = false
cpu_utilization_threshold             = "80"
freeable_memory_threshold             = "10000000"
free_storage_space_threshold          = "5000000000"
snapshot_identifier                   = ""
port                                  = "5432"
performance_insights_enabled          = true
performance_insights_retention_period = "7"


######### EFS Variables ###############
create_efs    = true
efs_encrypted = true

#########  Bastion Variables ##########
create_bastion              = true
ec2_instance_type           = "t3.medium"
noc_ssh_key                 = "test"
associate_public_ip         = true
noc_cidr_blocks             = ["0.0.0.0/0", "10.30.0.0/16"]
root_vol_size               = "50"
create_noc_key              = true
create_node_key             = true
user_data_replace_on_change = true



