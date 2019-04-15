#Autoscaling launch configuration

resource "aws_launch_configuration" "asg_launch" {
  name          = "asglaunch"
  image_id      = "${var.image}"
  instance_type = "${var.instance}"
  key_name	= "${var.key}"
  }

  #Auto Scaling Group
    resource "aws_autoscaling_group" "terraform_asg" {
    name                 = "terraformasg"
    max_size                  = 2
    min_size                  = 1
    health_check_grace_period = 300
    health_check_type         = "EC2"
    desired_capacity          = 1
    launch_configuration      = "${aws_launch_configuration.asg_launch.name}"
    vpc_zone_identifier       = "${aws_subnet.public.id}"
    load_balancers            = "${aws_elb.elbinstances.name}"
    availability_zones        = "[us-east-1a]"

   }
