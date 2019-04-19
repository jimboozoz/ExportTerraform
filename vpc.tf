provider "aws" {
	access_key = "${var.aws_access_key}"
	secret_key = "${var.aws_secret_key}"
	region     = "${var.region}"
}

#VPC Configuration

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "VPCTerraform"
  }
}

#Gateway Configuration
resource "aws_internet_gateway" "gateway" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "GatewayTerraform"
  }
}

#Public subnet with respective route

resource "aws_subnet" "public" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = "true" 

  tags = {
    Name = "PublicSubTerraform"
  }
}

resource "aws_route_table" "publicroute" {
    vpc_id = "${aws_vpc.main.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gateway.id}"
    }
}

resource "aws_route_table_association" "publicassociation" {
    subnet_id = "${aws_subnet.public.id}"
    route_table_id = "${aws_route_table.publicroute.id}"
}

#Private subnet with respective route

resource "aws_subnet" "private" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "PrivateSubTerraform"
  }
}

resource "aws_route_table" "privateroute" {
    vpc_id = "${aws_vpc.main.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gateway.id}"
    }
}

resource "aws_route_table_association" "privateassociation" {
    subnet_id = "${aws_subnet.private.id}"
    route_table_id = "${aws_route_table.privateroute.id}"
}
