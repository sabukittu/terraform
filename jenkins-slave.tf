provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "JenkinsSlave-Docker" {
  ami           = "ami-0affd4508a5d2481b"
  instance_type = "t2.micro"
  key_name      = "ksabu_devsecops_noobies"
  security_groups = ["JenkinsDocker-SG"]
  ebs_block_device {
    device_name = "/dev/sda1"
    delete_on_termination = true
  }
  user_data = file("./userdata.sh")
  tags = {
    Name = "dev-JenkinsSlave"
  }
}

output "IPAddress" {
  value = aws_instance.JenkinsSlave-Docker.private_ip
}