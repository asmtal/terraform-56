resource "aws_elastic_beanstalk_application" "Gredinja" {
    name = "Gredinja-web-environment"
    description = "Gredinja-test-environment"
}

resource "aws_elastic_beanstalk_environment" "Gredinja" {
    name = "Gredinja-web-environment"
    application = "${aws_elastic_beanstalk_application.Gredinja.name}"
    solution_stack_name = "64bit Amazon Linux 2016.03 v2.1.6 running Docker 1.11.2" 
setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAddress"
    value = "false"
    }
setting {
  namespace = "aws:autoscaling:launchconfiguration"
  name = "IamInstanceProfile"
  value = "arn:aws:iam::093234080301:instance-profile/ChefServer"
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
  name = "BUCKET_WITH_SECRET_KEYS"
  value = "kordata-Gredinja"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:Docmosis:Server"
  value = "http://docmosis.sandbox.kordata.com:8080/rs/render"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:Email:From"
  value = "donotreply@kordata.com"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:Email:Password"
  value = "AgBLIHoL/vxQd0OiUF8Y543gcF0ZKdPdS72xy8ITgQ23"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:Email:Port"
  value = "587"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:Email:Server"
  value = "email-smtp.us-west-2.amazonaws.com"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:Email:UserName"
  value = "AKIAI5QDCWGGPKTDKF3A"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:N1qlConnection:Bucket"
  value = "sandbox_sync_gateway"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:N1qlConnection:Servers"
  value = "http://couchbase.sandbox.kordata.com:8091/pools"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:N1qlConnection:UseSsl"
  value = "false"
    }
    setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:Security:KeyFolder"
  value = "webkey"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:SyncGateway:GatewayName"
  value = "sandbox_sync_gateway"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Data:SyncGateway:Server"
  value = "http://sync-gateway.sandbox.kordata.com:4985"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Features:DisableSecureCookie"
  value = "false"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "Hosting:Environment"
  value = "development"
    }
setting {
  namespace = "aws:elasticbeanstalk:application:environment"
  name = "PublicRootUrl"
  value = "https://sandbox.kordata.com"
    }
}

resource "aws_elastic_beanstalk_application" "Gredinja-cldaemon" {
    name = "Gredinja-cldaemon-environment"
    description = "Gredinja-cldaemon-test-environment"
}

resource "aws_elastic_beanstalk_environment" "Gredinja-cldaemon" {
    name = "Gredinja-cldaemon-environment"
    application = "${aws_elastic_beanstalk_application.Gredinja-cldaemon.name}"
    solution_stack_name = "64bit Amazon Linux 2016.03 v2.1.6 running Docker 1.11.2" 
setting {
    namespace = "aws:ec2:vpc"
    name = "AssociatePublicIpAddress"
    value = "false"
    }
setting {
  namespace = "aws:autoscaling:launchconfiguration"
  name = "IamInstanceProfile"
  value = "arn:aws:iam::093234080301:instance-profile/ChefServer"
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
  value = "http://couchbase.sandbox.kordata.com:8091/pools"
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
  value = "http://sync_gateway.sandbox.kordata.com:4985"
    }
}