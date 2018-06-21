Simple deployment of a Ruby application to AWS using CloudFormation
=============================================================


This solution deploys a Ruby web application to AWS using CloudFormation 'configuration-as-code' for orchestration. 


Requirements 
------------------


Linux machine to complete the work on. Project developed with Ubuntu 18.04. 

Amazon Web Services user account with CLI and console access. The IAM policy applied to the user must allow for adequate (or full) access to CloudFormation, S3, EC2 and ElasticBeanstalk. 
	 
AWS CLI software installed and configured. Make sure the AWS CLI has been configured for the right AWS account using correct access keys. 

Git CLI software. 

ZIP CLI software. 


Assumptions 
------------------


The S3 bucket 'sinatra-jamesh' is available. If not, edit the name on line 15 of sinartra_cfm.template. 

The CloudFormation stack name 'SinatraJamesh' is available. 

The Elastic Beanstalk application name 'SinatraJamesh' is available.


Installation 
------------------


Setting up local environment and deploying the application to AWS
=================================================================

    git clone https://github.com/dryberg/SimpleSinatraApplication.git
    cd SimpleSinatraApplication/
    ./SETUP.sh

In the AWS Console navigate to CloudFormation - https://ap-southeast-2.console.aws.amazon.com/cloudformation
Select 'Create Stack' > 'Select a sample template' > Upload 'sinatra_cfm.template' and hit next > Enter stack name "SinatraJamesh" and hit next > Next > Create 

See 'Shortcomings' section for info on deploying from command line instead of using the AWS Console. 


View the site 
------------------

Run the following command from the CLI to get the applications URL 


    aws elasticbeanstalk describe-environments | grep -oP '(?<="CNAME": ")[^"]*'

This assumes no other sites are managed by Elastic Beanstalk, it may be easier getting the URL from the Elastic Beanstalk web interface. https://ap-southeast-2.console.aws.amazon.com/elasticbeanstalk 

See this guide on location the sites URL - https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/customdomains.html 



Removal 
------------------


    ./DELETE.sh

Deletes S3 bucket and deletes CloudFormation stack. 


Application server 
------------------


AWS EC2 instance managed by Elastic Beanstalk that is deployed using Cloud Formation. 

I chose to use CloudFormation in conjunction with Elastic Beanstalk to achieve the configuration as code objectives. These are the orechestration tools I am most familiar with, I recognise container services used in conjunction with tools such as Puppet and Ansible have become an industry standard. 


Security 
---------


The host is member of a security group that only allows traffic over HTTP to Port 80. This security group was created for this application and will be removed upon deletion of the stack in CloudFormation.  

SSH access has not been enabled. 


Shortcomings 
---------------------


The cloud formation script can only be deployed from command line when using it's full path 

    "aws cloudformation deploy --template-file ~/Documents/sinartra/sinarta_cfm.json --stack-name SinatraJamesh"

For this reason, not knowing the local directory that the git repo will be cloned into, I've provided instructions for deploying through the CloudFormation console. 

Security could be improved by setting a Key Pair for SSH authentication and only granting SSH access to known IP addresses. 

No health checks or self healing has been configured. Since the application is deployed to Elastic Beanstalk, health checks and a highly-available self-healing configuration can easily be achieved. 

No monitoring dashboard. For any production system, monitoring should be included in the solution.

The names used for environments, security groups and other resources are not meaningful. This would not be such an issue if tags were used.

No tagging of resources. Tagging would make it easy to identify resources associated with the solution and allows for greater analytics such as cost.  
