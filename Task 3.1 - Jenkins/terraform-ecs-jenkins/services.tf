
locals {
  jsondata = templatefile("./jenkins.json.tpl", {
    EFSJenkinsVolume = "EFSJenkinsVolume"
  })
}

resource "aws_ecs_task_definition" "jenkins" {
  family                = "jenkins"
  container_definitions = local.jsondata
  task_role_arn         = "arn:aws:iam::417211443250:role/ecs-task-test-role"

  volume {
    name = "EFSJenkinsVolume"

    efs_volume_configuration {
      file_system_id = data.aws_efs_file_system.efs.id
    }
  }
  volume {
    name = "docker"
    host_path = "/var/run/docker.sock"
  }
}

resource "aws_ecs_service" "jenkins" {
  name            = "jenkins"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.jenkins.arn
  desired_count   = 1
}

/*resource "aws_ecs_task_definition" "app" {
  family                = "app"
  container_definitions = file("./task-defenition.json")
}*/