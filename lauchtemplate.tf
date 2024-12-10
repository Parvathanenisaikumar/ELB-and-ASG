resource "aws_launch_template" "template" {
  image_id               = "ami-0166fe664262f664c"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg.id]



  user_data = base64encode(<<-EOF
#!/bin/bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl enable httpd 
sudo systemctl start httpd 
sudo systemctl restart httpd
sudo touch /var/www/html/index.html
sudo chmod 777 /var/www/html/index.html 
sudo echo "<html><h1>demo application deployed</h1><h2>success!</h2></html>" >> /var/www/html/index.html
EOF
  )
}
