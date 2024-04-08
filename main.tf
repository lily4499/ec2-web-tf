# Declare provider (AWS in this case)
provider "aws" {
  region = "us-east-1"  # Specify your desired AWS region
}

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

# Resource block to create an EC2 instance
resource "aws_instance" "ec2_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  security_groups = var.security_groups

  # Optional: Customize EC2 instance settings
  tags = {
    Name        = "MyEC2Instance"
    Environment = "Production"
    Owner       = "Terraform"
  }

  # Optional: Define user data (e.g., script to run on instance launch)
  user_data = <<-EOF
    #!/bin/bash
    echo "Hello from Terraform provisioned EC2 instance!"
    # Add more custom user data here
  EOF

  # Optional: Configure EBS volume (example)
  ebs_block_device {
    device_name = "/dev/sdh"
    volume_type = "gp2"
    volume_size = 10
  }

  # Optional: Enable detailed monitoring (example)
  monitoring = true
  
}

# Output block to display the public IP address and SSH command
output "instance_public_ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "ssh_command" {
  value = "ssh -i /home/lili/.ssh/ec2-ssh-key ubuntu@${aws_instance.ec2_instance.public_ip}"
}
