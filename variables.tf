# Declare variables (optional but recommended for flexibility)

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-0c7217cdde317cfec"  # Ubuntu 22 AMI (change as needed)
}

variable "key_name" {
  default = "ec2-ssh-key.pub"  # Name of your EC2 key pair
}

variable "subnet_id" {
  default = "subnet-062bafb72ff1b9c71"  # Subnet ID where the instance will be launched
}

variable "security_groups" {
  default = ["sg-091906568d27d3894"]  # List of security group IDs
}
