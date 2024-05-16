/*key_name               = "jenkins_server" */
resource "aws_instance" "jenkins_instance" {
  ami                    = "ami-0b752bf1df193a6c4"                        # Update with the desired Amazon Machine Image (AMI) ID
  instance_type          = lookup(var.instance_type, terraform.workspace) # Update with the desired instance type
  key_name               = data.aws_key_pair.jenkins_server.key_name                              # Update with the name of your key pair
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              set -e

              # Update all packages
              sudo yum update -y

              # Install Java Development Kit (JDK)
              sudo amazon-linux-extras install java-openjdk11 -y

              # Import Jenkins key and add Jenkins repository
              sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
              sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

              # Install Jenkins
              sudo yum install -y jenkins

              # Start Jenkins service
              sudo systemctl start jenkins
              sudo systemctl enable jenkins

              # Wait for Jenkins to start
              sleep 60

              # Install Jenkins plugins
              sudo su - jenkins -c 'java -jar /usr/lib/jenkins/jenkins.war -s http://localhost:8080 install-plugin terraform github'

              # Restart Jenkins to apply changes
              sudo systemctl restart jenkins
            EOF

  provisioner "local-exec" {
    command = "echo ${aws_instance.jenkins_instance.public_ip} > var.jenkins_instance_ip.txt"
  }

  tags = {
    Name        = "${var.project}-Jenkins"
    Environment = terraform.workspace
  }

 # lifecycle {
 #      prevent_destroy = true
 # }

}

  data "aws_key_pair" "jenkins_server"{
    key_name = "jenkins_server"
  }
