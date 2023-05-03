resource "aws_security_group" "MYSG" {
  name = "Bastion-SG"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "71.163.48.190/32", "209.183.243.114/32", "73.213.124.24/32"
    ]
  }


   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastionSG-DevSecOps"
    Department = "DevSecOps Associate" 
    Creation = "terraform"
  }

}

resource "aws_security_group" "JSG" {
  name = "Jenkins-SG"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [format("%s/32", aws_instance.bastion.private_ip)]
  }

  ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"

    security_groups = [aws_security_group.ALB-SG.id]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    security_groups = [aws_security_group.ALB-SG.id]
  }

   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    tags = {
    Name = "JSG-DevSecOps"
    Department = "DevSecOps Associate" 
    Creation = "terraform"
  }

}

  resource "aws_security_group" "ALB-SG" {
  name = "ALB-SG"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 81
    to_port   = 81
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

    tags = {
    Name = "ALBSG-DevSecOps"
    Department = "DevSecOps Associate" 
    Creation = "terraform"
    project = "interns"
  }

}
