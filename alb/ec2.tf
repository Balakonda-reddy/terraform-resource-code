
# for key pair purpose

resource "aws_key_pair" "key" {
  key_name   = "k1"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDeAIhH1gFXTS/wpPyx0gpfjEqjMLEa1nGCnGq0odQoU7Bj0Smn9zrGv/p20gaWZ6sQIP5NlhT58B92PvVMhncXs0gGkfST6EJOtbZHxBSwcPrqOuO2pRHujA9ZB8kgjwWJEiRHuESgi85ef87zzudv52NaRRfzlIffC39Gl7zDvChroydjXm5WHiGY2klzIohdXVJck5hD/mXMb97fktwD9UEqhrbRd501MHJHnL/ubr6AXBznDOa+2DniIyD8xTu1/j1qvFA5JkoS/N3IEd8BCwe1xFPlULW7Aaibk1w25AopmpLcp4E/ykYw5FbYm/6Or5+r2hAWuHu6Kx5e0tgiOTqnI65SiWuPWRvlaHQuwAAtACjjier9KG01FrC/jZkRrfdtlFHlIY4nvEWGfJRlqcwxhX6dtdMRUQ/QZqV/o2Ukn9RQObPmvVahGkQmgmDIYCWZr4AFtmUzLwu2efaAWS9SWf96mMFRraG6MmEwk2hOApJOtCkQ1YkZVsAcq5s= china@BALU"
}

# for instance purpose

# FOR EC2 1

resource "aws_instance" "instance" {
    ami = "ami-052cef05d01020f1d"
    instance_type = "t2.micro"
    key_name = "k1"
    vpc_security_group_ids = [aws_security_group.ec2-sg1.id]
    user_data = <<EOF

    #!/bin/bash
    yum update -y
    yum install httpd -y 
    systemctl enable httpd
    systemctl start httpd
    mkdir -p  /var/www/html/chess/
    echo "this is chess" >/var/www/html/chess/index.html

    EOF 

    tags = {
        Name = "i1"
    }
}

# FOR EC2 2

resource "aws_instance" "instance1" {
    ami = "ami-052cef05d01020f1d"
    instance_type = "t2.micro"
    key_name = "k1"
    vpc_security_group_ids = [aws_security_group.ec2-sg1.id]
    user_data = <<EOF

    #!/bin/bash
    yum update -y
    yum install httpd -y 
    systemctl enable httpd
    systemctl start httpd
    mkdir -p  /var/www/html/sudoku/
    echo "this is sudoku" >/var/www/html/sudoku/index.html

    EOF 

    tags = {
        Name = "i2"
    }
}
