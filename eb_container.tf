

resource "aws_elastic_beanstalk_application" "environment-daemons" {
    name = "environment-daemons-environment"
    description = "environment-daemon-environment"
}

resource "aws_elastic_beanstalk_environment" "environment-cldaemon" {
    name = "environment-cldaemon-environment"
    application = "${aws_elastic_beanstalk_application.environment-daemons.name}"
    solution_stack_name = "64bit Amazon Linux 2016.03 v2.1.6 running Docker 1.11.2" 
setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAddress"
    value = "false"
    }
setting {
  namespace = "aws:autoscaling:launchconfiguration"
  name = "IamInstanceProfile"
  value = "arn:aws:iam::XXXXXXXXXXXX:instance-profile/SomeCategoryName"
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
    value = "m4.large"
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
  value = "https://couchbase.environment.com:18091/pools"
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
  value = "https://sync_gateway.environment.com:4985"
    }
tags {
  Environment = "environment"
  Category = "SomeCategoryName"
  }
}

resource "aws_elastic_beanstalk_environment" "environment_doxpiry" {
    name = "environment-doxpiry-environment"
    application = "${aws_elastic_beanstalk_application.environment-daemons.name}"
    solution_stack_name = "64bit Amazon Linux 2016.03 v2.1.6 running Docker 1.11.2" 
setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAddress"
    value = "false"
    }
setting {
  namespace = "aws:autoscaling:launchconfiguration"
  name = "IamInstanceProfile"
  value = "arn:aws:iam::XXXXXXXXXXX:instance-profile/SomeProfileName"
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
    value = "m4.large"
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
  value = "https://couchbase.environment.com:18091/pools"
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
  value = "https://sync_gateway.environment.com:4985"
    }
setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name = "DocumentExpiration:DelayTillNextRunSeconds"
    value = "86400"
}
tags {
    Environment = "environment"
    Category = "SomeCategoryName"
  }
}
