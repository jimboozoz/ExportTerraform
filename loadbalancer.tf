resource "aws_elb" "elbinstances" {
	name               	= "elbterraform"
  security_groups 		= ["${aws_security_group.elb_sg.id}"]
	subnets							= ["${aws_subnet.public.id}"]

	listener {
    instance_port     = "80"
    instance_protocol = "HTTP"
    lb_port           = "80"
    lb_protocol       = "HTTP"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }


 tags {
		Name = "TerraformELB"
	}

}

resource "aws_security_group" "elb_sg" {

name        = "elbsg"
description = "Allow Ports 80 and 22"
vpc_id      = "${aws_vpc.main.id}"

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

tags {
		Name = "ELBterraform"
	}
}
