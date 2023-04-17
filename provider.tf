provider "aws" {
    region = var.region
    default_tags {
    tags = {
        Environment      = var.stage
        Owner            = "DevOps team"
        Organization     = var.namespace
        }
    }
}

provider "kubernetes" {
    host                     = module.eks-cluster[0].cluster_endpoint
    # token                  = module.eks-cluster[0].eks_cluster_token
    exec {
        api_version          = "client.authentication.k8s.io/v1beta1"
        command              = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
        args = ["eks", "get-token", "--cluster-name", module.eks-cluster[0].cluster_name]
    }
    cluster_ca_certificate   = base64decode(module.eks-cluster[0].cluster_certificate_authority_data)
}