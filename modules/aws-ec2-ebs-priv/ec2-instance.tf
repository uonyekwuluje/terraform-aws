resource "aws_instance" "linux_instance" {
  count                  = var.node_count
  ami                    = var.aws_ami
  instance_type          = var.aws_type
  subnet_id              = var.private_subnet_1_id
  vpc_security_group_ids = [var.security_group]
  key_name               = "deploy-key" 

  root_block_device {
    volume_type  =  "gp2"
    volume_size  =  var.root_disk_size
    delete_on_termination  = true
  }

  tags = {
    Environment = var.environment
    Name        = "${var.server_name}-${count.index}" 
 }
}


resource "aws_ebs_volume" "data-vol" {
   availability_zone = aws_instance.linux_instance[count.index].availability_zone
   count  = var.node_count
   size = 20
   tags = {
        Name = "${var.server_name}-data-volume-${count.index}"
   }
}

resource "aws_volume_attachment" "attach-vol" {
  count  = var.node_count
  device_name = "/dev/sdc"
  volume_id = element(aws_ebs_volume.data-vol.*.id, count.index)
  instance_id = element(aws_instance.linux_instance.*.id, count.index)
}

output "PRIVLinux_private_address" {
  value = aws_instance.linux_instance.*.private_dns
}
