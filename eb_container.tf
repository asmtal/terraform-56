

resource "aws_elastic_beanstalk_application" "greninja-daemons" {
    name = "greninja-daemons-environment"
    description = "greninja-daemon-environment"
}

resource "aws_elastic_beanstalk_environment" "greninja-cldaemon" {
    name = "greninja-cldaemon-environment"
    application = "${aws_elastic_beanstalk_application.greninja-daemons.name}"
    solution_stack_name = "64bit Amazon Linux 2016.03 v2.1.6 running Docker 1.11.2" 
setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAddress"
    value = "false"
    }
setting {
  namespace = "aws:autoscaling:launchconfiguration"
  name = "IamInstanceProfile"
  value = "arn:aws:iam::905856206022:instance-profile/Kordata"
}
setting {
        namespace = "aws:ec2:vpc"
        name = "VPCid"
        value = "${aws_vpc.default.id}"
    }
setting {
        namespace = "aws:ec2:vpc"
        name = "Subnets"
        value = "${aws_subnet.us-west-2a-private.id}"
    }
setting {
    namespace = "aws:ec2:vpc"
    name = "ELBScheme"
    value = "internal"
  }
setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = "t2.small"
  }
setting {
    namespace = "aws:autoscaling:asg"
    name = "Availability Zones"
    value = "Any 2"
  }
setting {
    namespace = "aws:autoscaling:asg"
    name = "MinSize"
    value = "1"
  }
setting {
    namespace = "aws:autoscaling:asg"
    name = "MaxSize"
    value = "2"
  }
setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "ServiceRole"
    value = "aws-elasticbeanstalk-service-role"
  }
setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name = "SystemType"
    value = "enhanced"
  }
setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "RollingUpdateEnabled"
    value = "true"
  }
setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "RollingUpdateType"
    value = "Health"
  }
setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "MinInstancesInService"
    value = "1"
  }
setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "MaxBatchSize"
    value = "1"
  }
setting {
    namespace = "aws:elb:loadbalancer"
    name = "CrossZone"
    value = "true"
  }
setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "BatchSizeType"
    value = "Fixed"
  }
setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "BatchSize"
    value = "1"
  }
setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "DeploymentPolicy"
    value = "Rolling"
  }
setting {
    namespace = "aws:elb:policies"
    name = "ConnectionDrainingEnabled"
    value = "true"
  }
setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "SecurityGroups"
    value = "${aws_security_group.private.id}"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:N1qlConnection:Bucket"
  value = "sandbox_sync_gateway"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:N1qlConnection:Servers"
  value = "https://couchbase.greninja.kordata.com:18091/pools"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:N1qlConnection:UseSsl"
  value = "false"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:SyncGateway:GatewayName"
  value = "sandbox_sync_gateway"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:SyncGateway:Server"
  value = "https://sync_gateway.greninja.kordata.com:4985"
    }
}

resource "aws_elastic_beanstalk_environment" "greninja_doxpiry" {
    name = "greninja-doxpiry-environment"
    application = "${aws_elastic_beanstalk_application.greninja-daemons.name}"
    solution_stack_name = "64bit Amazon Linux 2016.03 v2.1.6 running Docker 1.11.2" 
setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAddress"
    value = "false"
    }
setting {
  namespace = "aws:autoscaling:launchconfiguration"
  name = "IamInstanceProfile"
  value = "arn:aws:iam::905856206022:instance-profile/Kordata"
}
setting {
        namespace = "aws:ec2:vpc"
        name = "VPCid"
        value = "${aws_vpc.default.id}"
    }
setting {
        namespace = "aws:ec2:vpc"
        name = "Subnets"
        value = "${aws_subnet.us-west-2a-private.id}"
    }
setting {
    namespace = "aws:ec2:vpc"
    name = "ELBScheme"
    value = "internal"
  }
setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = "t2.small"
  }
setting {
    namespace = "aws:autoscaling:asg"
    name = "Availability Zones"
    value = "Any 2"
  }
setting {
    namespace = "aws:autoscaling:asg"
    name = "MinSize"
    value = "1"
  }
setting {
    namespace = "aws:autoscaling:asg"
    name = "MaxSize"
    value = "2"
  }
setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "ServiceRole"
    value = "aws-elasticbeanstalk-service-role"
  }
setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name = "SystemType"
    value = "enhanced"
  }
setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "RollingUpdateEnabled"
    value = "true"
  }
setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "RollingUpdateType"
    value = "Health"
  }
setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "MinInstancesInService"
    value = "1"
  }
setting {
    namespace = "aws:autoscaling:updatepolicy:rollingupdate"
    name = "MaxBatchSize"
    value = "1"
  }
setting {
    namespace = "aws:elb:loadbalancer"
    name = "CrossZone"
    value = "true"
  }
setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "BatchSizeType"
    value = "Fixed"
  }
setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "BatchSize"
    value = "1"
  }
setting {
    namespace = "aws:elasticbeanstalk:command"
    name = "DeploymentPolicy"
    value = "Rolling"
  }
setting {
    namespace = "aws:elb:policies"
    name = "ConnectionDrainingEnabled"
    value = "true"
  }
setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "SecurityGroups"
    value = "${aws_security_group.private.id}"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:N1qlConnection:Bucket"
  value = "sandbox_sync_gateway"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:N1qlConnection:Servers"
  value = "https://couchbase.greninja.kordata.com:18091/pools"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:N1qlConnection:UseSsl"
  value = "false"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:SyncGateway:GatewayName"
  value = "sandbox_sync_gateway"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:SyncGateway:Server"
  value = "https://sync_gateway.greninja.kordata.com:4985"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "DocumentExpiration:DelayTillNextRunSeconds"
    value = "86400"
}
}