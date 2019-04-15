#Adding an RDS subnet groun resource on both public and private subnets
resource "aws_db_subnet_group" "db_subnet" {
  name       = "main"
  subnet_ids = ["${aws_subnet.private.id}","${aws_subnet.public.id}" ]

  tags {
    Name = "TerraformSubnetDB"
  }
}

resource "aws_db_instance" "db_image" {
	allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydatabase"
  username             = "mydatabase"
  password             = "mydatabase"
	db_subnet_group_name = "${aws_db_subnet_group.db_subnet.id}"
	vpc_security_group_ids = ["${aws_security_group.database_sg.id}"]
	skip_final_snapshot = "true"

 tags {
		Name = "TerraformDBInstance"
 }
}

resource "aws_security_group" "database_sg" {

name        = "databasesg"
vpc_id      = "${aws_vpc.main.id}"

ingress {
		 from_port = 9043
		 to_port = 9043
		 protocol = "tcp"
		 cidr_blocks = ["0.0.0.0/0"]
}

tags {
		Name = "DatabaseTerraSG"
	}
}
