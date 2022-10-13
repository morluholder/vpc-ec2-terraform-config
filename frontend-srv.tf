# EC2 RESOURCE

resource "aws_instance" "frontend-srv" {
  ami           = "ami-0149b2da6ceec4bb0"
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.frontend-srv-sg.id ]
  key_name = "dev3-kp"
  subnet_id = aws_subnet.public-sn1.id
  associate_public_ip_address = true

  root_block_device {
    volume_size = 25
    delete_on_termination = true
  }

  tags = {
    Name = "frontend-google-srv"
  }
}

# EC2 SECURITY GROUP RESOURCE

resource "aws_security_group" "frontend-srv-sg" {
  name        = "frontend-srv-sg"
  description = "Allow  traffic to frontend srv"
  vpc_id      = aws_vpc.main-vpc.id

  ingress = [ 
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = true
    },

    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["71.150.189.42/32"]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = true
    }
 ]

  egress = [ 
    {
      description = "for all outbound traffic"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = []
      security_groups = []
      self = false
    }
  ]

  tags = {
    Name = "frontend-google-srv-sg"
  }
}