
# Provisioning an Ubuntu instance
# Resource block to create an EC2 instance
resource "aws_instance" "webserver" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  security_groups = var.security_groups

  # Optional: Customize EC2 instance settings
  tags = {
    Name        = "webserver"
    Environment = "Production"
    Owner       = "Terraform"
  }

# Executing commands on the server
resource "null_resource" "deploy_website" {
  connection {
    type        = "ssh"
    user        = "ubuntu"  # User for the AMI (e.g., ubuntu for Ubuntu AMI)
    private_key = file("~/.ssh/ec2-ssh-key")  # Path to your private SSH key
    host        = aws_instance.webserver.public_ip
  }

  provisioner "local-exec" {
    command = <<EOT
      # Commands to install Apache2 and deploy website files
      ssh -i ~/.ssh/ec2-ssh-key ubuntu@${aws_instance.web_server.public_ip} sudo apt-get update
      ssh -i ~/.ssh/ec2-ssh-key ubuntu@${aws_instance.web_server.public_ip} sudo apt-get install -y apache2
      scp -i ~/.ssh/ec2-ssh-key -r /home/lili/website ubuntu@${aws_instance.web_server.public_ip}:/var/www/html
      ssh -i ~/.ssh/ec2-ssh-key ubuntu@${aws_instance.webserver.public_ip} sudo systemctl restart apache2
    EOT
  }
}

# Output block to display the public IP address and SSH command
output "instance_public_ip" {
  value = aws_instance.webserver.public_ip
}

output "ssh_command" {
  value = "ssh -i /home/lili/.ssh/ec2-ssh-key ubuntu@${aws_instance.webserver.public_ip}"
}
