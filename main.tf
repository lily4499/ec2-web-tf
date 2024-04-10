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
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("~/.ssh/ec2-ssh-key")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apache2",
      "sudo systemctl restart apache2"
    ]

    // Copy the website files to the remote server
    // This assumes you have a directory named 'website' locally
    // and want to copy it to '/var/www/html' on the remote server
    inline_shebang = [
      "scp -r -i ~/.ssh/ec2-ssh-key /home/lili/website ubuntu@${self.public_ip}:/var/www/html"
    ]
  }
}

# Output block to display the public IP address and SSH command
output "instance_public_ip" {
  value = aws_instance.webserver.public_ip
}

output "ssh_command" {
  value = "ssh -i /home/lili/.ssh/ec2-ssh-key ubuntu@${aws_instance.webserver.public_ip}"
}
