#App Server
resource "aws_instance" "appserver" {
        ami = "${var.image}"
        instance_type = "${var.instance}"
				vpc_security_group_ids	 = ["${aws_security_group.appserver_sg.id}"]
				subnet_id = "${aws_subnet.public.id}"

#Apache Installation and creating of index file
				user_data = <<-EOF
					    #!/bin/bash
					    sudo yum update -y
					    sudo yum install -y httpd
                                            sudo service httpd start
                                            sudo chkconfig httpd on
                                            sudo cd /var/www/html
                                            sudo echo "This is the Main Website" > index.html
					    EOF


 tags {
		Name = "AppserverTerraform"
 }
}

#App Server SG
resource "aws_security_group" "appserver_sg" {

name        = "appserversg"
vpc_id      = "${aws_vpc.main.id}"

ingress {
		 from_port = 9043
		 to_port = 9043
		 protocol = "tcp"
		 cidr_blocks = ["0.0.0.0/0"]
}

ingress {
		 from_port = 22
		 to_port = 22
		 protocol = "tcp"
		 cidr_blocks = ["0.0.0.0/0"]
}

tags {
		Name = "AppserverTerraSG"
	}
}
