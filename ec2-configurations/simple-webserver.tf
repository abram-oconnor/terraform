provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami                    = "ami-006dcf34c09e50022"
  instance_type          = "t2.micro"
  key_name               = "Test Web Server"
  vpc_security_group_ids = ["sg-0a39cb13d7fae5927"]
  user_data              = <<-EOF
              #!/bin/bash
              # Use this for your user data (script from top to bottom)
              # install httpd (Linux 2 version)
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "test-web-server"
  }
}

