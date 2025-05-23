# Guidance-for-Deploying-Moodle-Learning-Management-System-on-AWS-and-Terraform

![Screenshot 2025-05-23 150637](https://github.com/user-attachments/assets/48d09093-acc9-4def-bd2a-14f15202dda8)

## Step 1
Amazon Route 53 offers a scalable cloud DNS
web service. It directs students to the closest
Amazon CloudFront location to access the
Moodle web application content while reducing
latency.

## Step 2
CloudFront provides access to the Moodle
web application server, which sits behind
Application Load Balancer (ALB), providing low
latency access to content while serving cached
content from edge locations spread across the
globe.

## Step 3
AWS Certificate Manager (ACM) manages
SSL certificates for secure, encrypted
communication with public and private
resources. It provides free SSL certificates that
integrate with CloudFront or ALB with
automated certificate rotation

## Step 4
ALB automatically distributes incoming traffic to
Moodle web application servers. The internet
gateway provides an entry point to virtual
private cloud (VPC) resources inside the public
subnet, providing access to ALB

## Step 5
Network address translation (NAT) gateway
allows outbound traffic for resources within a
private subnet, such as the Moodle app server,
that requires internet access

## Step 6
The Moodle app server is deployed horizontally
using auto scaling groups with multiple
Amazon Elastic Compute Cloud (Amazon
EC2) instances across multiple Availability
Zones (AZs), which are deployed in a separate
private subnet for additional security. An AWS
Systems Manager Agent (SSM Agent) can be
configured on the instances to provide SSH
access without exposing an SSH port

## Step 7
Amazon Elastic File System (Amazon EFS)
can be used to store moodledata and other
content, providing consistent performance, high
availability, and durability

## Step 8
Amazon ElastiCache with Redis OSS
Compatibility or Amazon ElastiCache for
Memcached stores Moodle sessions and
application caches in managed clusters with
replicas across AZs.

## Step 9
Amazon Aurora offers both MySQL- and
PostgreSQL-compatible global scale database
clusters. It provides on-demand scale of replica
instances within minutes to handle workload
spikes during peak periods

## Step 10
Git repository hosts Moodle’s PHP codebase
and continuous integration, continuous delivery
(CI/CD) configuration files. AWS CodeBuild
compiles source code, runs tests, and produces
software packages ready to deploy onto the
Moodle app server. AWS CodeDeploy
manages the complexity of updating
applications. It can deploy into Moodle with
zero downtime using blue-green deployment
methodologies. AWS CodePipeline automates
the build, test, and deploy phases for code
changes.

## Step 11
AWS Secrets Manager protects Moodle
application secrets and rotates secrets
automatically to match lifecycle requirements

## Step 12
Parameter Store, a capability of Systems
Manager, manages Moodle’s configuration
parameters, including shared storage
endpoints, databases, and cache configuration.
This avoids the security risk associated with
hard-coding configuration within the codebase
or environment




