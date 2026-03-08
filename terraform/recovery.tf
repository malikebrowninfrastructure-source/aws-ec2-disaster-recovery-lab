resource "aws_ebs_volume" "recovered_volume" {
  availability_zone = aws_instance.app_server.availability_zone
  snapshot_id       = "snap-034d7ece4bf107896"
  type              = "gp3"

  tags = {
    Name = "dr-lab-recovered-volume"
  }
}

resource "aws_volume_attachment" "recovered_attach" {
  device_name = "/dev/sdf"
  volume_id   = aws_ebs_volume.recovered_volume.id
  instance_id = aws_instance.app_server.id

  force_detach = true
}

