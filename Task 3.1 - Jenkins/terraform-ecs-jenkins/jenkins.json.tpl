[
  {
    "name": "jenkins",
    "image": "vishnevskiyav/myjenkins-blueocean:2.361.4-3",
    "cpu": 1024,
    "memory": 2048,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 8080,
        "hostPort": 8080
      },
      {
        "containerPort": 50000,
        "hostPort": 50000
      }
    ],
    "mountPoints": [
      {
        "sourceVolume": "${EFSJenkinsVolume}",
        "containerPath": "/var/jenkins_home",
        "readOnly": false
      },
      {
        "sourceVolume": "docker",
        "containerPath": "/var/run/docker.sock"
      }
    ]
  }
]
