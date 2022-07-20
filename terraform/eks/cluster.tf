module "cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = "test-cluster"
  cluster_version = "1.22"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  node_security_group_additional_rules = {
    egress_all = {
        protocol      = "-1"
        from_port     = 0
        to_port       = 0
        type          = "egress"
        cidr_blocks   = ["0.0.0.0/0"]
    }
    cluster_api_istio = {
        protocol      = "tcp"
        from_port     = 15017
        to_port       = 15017
        type          = "ingress"
        source_cluster_security_group = true
    }
    worker_to_worker = {
        protocol        = "-1"
        type            = "ingress"
        self            = true
        from_port       = 0
        to_port         = 0
    }
  }

  eks_managed_node_groups = {
    generic_eu_west_1a = {
      min_size     = 2
      max_size     = 10
      desired_size = 2

      kubelet_extra_args            = "--node-labels=node.kubernetes.io/lifecycle=normal"
      suspended_processes           = ["AZRebalance"]
      spot_price                    = "0.020"
      instance_type                 = "t4g.macro"
    }
  }

}