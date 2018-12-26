provider "aws" {
  access_key  = "${var.access_key}"
  secret_key  = "${var.secret_key}"
  region      = "${var.region}"
}


resource "aws_instance" "web" {
  ami = "${lookup(var.ami, var.region)}"
  instance_type = "t2.micro"
  key_name = "your_key_name"
  security_groups = [
   "My-SG"
 ]

 provisioner "remote-exec" {
  inline = [
    "sudo yum install -y httpd",
    "sudo echo 'Welcome to my web page' > /var/www/html/index.html",
    "sudo /bin/systemctl restart httpd.service",
    ]
  }

  connection {
      type     = "ssh"
      user="${var.INSTANCE_USERNAME}"
      private_key="${file("${var.PATH_TO_PRIVATE_KEY}")}"
  }

 tags {
  name = "My-web"
   }

}

resource "aws_security_group" "My-SG" {
name = "My-SG"
description = "security group that allows ssh and all egress traffic"

  egress {
     from_port = 80
     to_port = 80
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
     from_port = 443
     to_port = 443
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   }
 ingress {
   from_port = 22
   to_port = 22
   protocol = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
  }
  lifecycle {
    prevent_destroy = true
  }

}
output "public_ip" {
  value = "${aws_instance.web.public_ip}"
}

output "public_dns" {
  value = "${aws_instance.web.public_dns}"
}
