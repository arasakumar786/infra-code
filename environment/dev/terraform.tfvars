vpc_name = "dev-vpc"
vpc_cidr = "10.16.0.0/16"
availability_zone_1 = "ap-south-1a"
availability_zone_2 = "ap-south-1b"
private_subnet_1_cidr = "10.16.1.0/24"
private_subnet_2_cidr = "10.16.2.0/24"
public_subnet_1_cidr = "10.16.10.0/24"
public_subnet_2_cidr = "10.16.11.0/24"
environment = "dev"
cluster_name = "dev-cluster"
cluster_version = "1.31"
eks_instance_types = ["t3.small"]
desired_size = 2
min_size = 1
max_size = 3
ami_id = "ami-034a8236c75419857"
aws_region = "ap-south-1"
instance_type = "t3.small"


