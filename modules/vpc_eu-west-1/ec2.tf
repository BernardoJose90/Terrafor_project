
resource "aws_instance" "jenkins_instance" {
  ami                    = "ami-0b752bf1df193a6c4"  # Update with the desired Amazon Machine Image (AMI) ID
  instance_type          = "t2.micro"        # Update with the desired instance type
  key_name               = "jenkins_server"   # Update with the name of your key pair
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  user_data = <<EOF
#!/bin/bash
sudo apt-get update
sudo apt-get install -y default-jdk
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install -y jenkins
EOF

  provisioner "local-exec" {
    command = "echo ${aws_instance.jenkins_instance.public_ip} > var.jenkins_instance_ip.txt"
  }

  tags = {
    Name = "jenkins-instance"
  }

  depends_on = [ aws_vpc.testvpc ]
}