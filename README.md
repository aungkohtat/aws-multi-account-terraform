# aws-multi-account-terraform
- we'll walk through a step-by-step guide on how to configure Terraform to interact with multiple AWS accounts seamlessly.anaging Multiple AWS Accounts with Terraform

### Prerequisites
1. Terraform CLI
2. aws CLI

### Step 1: Setting Up Your Terraform Directory
```
mkdir aws-multi-account-terraform
cd aws-multi-account-terraform
```
### Install AWS,TF CLI 
```
chmod +x install-aws-cli.sh
./install-aws-cli.sh
```

```
chmod +x install-terraform-cli.sh
./install-terraform-cli.sh
```

### Step 4: Creating Configuration Files
- provider.tf
Define the AWS providers for each account and region.

- data.tf
Fetch information from AWS using data sources.

- output.tf
Define outputs to display fetched data.

### Step 5: Initializing and Applying the Configuration
Initialize Terraform


```
terraform init
```

### Step 6: Adding AWS Credential
- ~/.aws/config
- `/.aws/credentials


```
sudo vim ~/.aws/credentials
aws configure --profile ygn-admin
aws configure --profile mdy-admin
aws configure --profile
```


```
[ygn]
aws_access_key_id = YOUR_YGN_ACCESS_KEY_ID
aws_secret_access_key = YOUR_YGN_SECRET_ACCESS_KEY
region = YOUR_YGN_REGION

[mdy]
aws_access_key_id = YOUR_MDY_ACCESS_KEY_ID
aws_secret_access_key = YOUR_MDY_SECRET_ACCESS_KEY
region = YOUR_MDY_REGION

```

**Check Output**

terraform init

```
vagrant@cloud-native-box:~/aws-multi-account-terraform/terraform$ terraform init
Initializing the backend...
Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v5.8.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
vagrant@cloud-native-box:~/aws-multi-account-terraform/terraform$ 
```

terraform plan

```
vagrant@cloud-native-box:~/aws-multi-account-terraform/terraform$ terraform plan
data.aws_caller_identity.mdyadmin: Reading...
data.aws_caller_identity.ygnadmin: Reading...
data.aws_vpc.mandalay_vpc: Reading...
data.aws_caller_identity.mdyadmin: Read complete after 1s [id=789190439145]
data.aws_caller_identity.ygnadmin: Read complete after 2s [id=669745465514]
data.aws_vpc.mandalay_vpc: Read complete after 2s [id=vpc-096aafcefd4ebc7b7]

Changes to Outputs:
  + aws_mandalay_vpc_arn = "arn:aws:ec2:us-east-1:789190439145:vpc/vpc-096aafcefd4ebc7b7"
  + aws_mdy_admin_arn    = "arn:aws:iam::789190439145:user/mdy"
  + aws_ygn_admin_arn    = "arn:aws:iam::669745465514:user/ygn"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
vagrant@cloud-native-box:~/aws-multi-account-terraform/terraform$ 
```


terraform apply

```
vagrant@cloud-native-box:~/aws-multi-account-terraform/terraform$ terraform apply
data.aws_caller_identity.mdyadmin: Reading...
data.aws_caller_identity.ygnadmin: Reading...
data.aws_vpc.mandalay_vpc: Reading...
data.aws_caller_identity.mdyadmin: Read complete after 1s [id=789190439145]
data.aws_caller_identity.ygnadmin: Read complete after 1s [id=669745465514]
data.aws_vpc.mandalay_vpc: Read complete after 3s [id=vpc-096aafcefd4ebc7b7]

Changes to Outputs:
  + aws_mandalay_vpc_arn = "arn:aws:ec2:us-east-1:789190439145:vpc/vpc-096aafcefd4ebc7b7"
  + aws_mdy_admin_arn    = "arn:aws:iam::789190439145:user/mdy"
  + aws_ygn_admin_arn    = "arn:aws:iam::669745465514:user/ygn"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

aws_mandalay_vpc_arn = "arn:aws:ec2:us-east-1:789190439145:vpc/vpc-096aafcefd4ebc7b7"
aws_mdy_admin_arn = "arn:aws:iam::789190439145:user/mdy"
aws_ygn_admin_arn = "arn:aws:iam::669745465514:user/ygn"
```


terraform state 

```
vagrant@cloud-native-box:~/aws-multi-account-terraform/terraform$ terraform state list
data.aws_caller_identity.mdyadmin
data.aws_caller_identity.ygnadmin
data.aws_vpc.mandalay_vpc
vagrant@cloud-native-box:~/aws-multi-account-terraform/terraform$ 
```


terraform output

```
vagrant@cloud-native-box:~/aws-multi-account-terraform/terraform$ terraform output
aws_mandalay_vpc_arn = "arn:aws:ec2:us-east-1:789190439145:vpc/vpc-096aafcefd4ebc7b7"
aws_mdy_admin_arn = "arn:aws:iam::789190439145:user/mdy"
aws_ygn_admin_arn = "arn:aws:iam::669745465514:user/ygn"
vagrant@cloud-native-box:~/aws-multi-account-terraform/terraform$ 
```
aws cli verification

```
# List EC2 instances
aws ec2 describe-instances --region us-west-1 --profile ygn-admin

# List S3 buckets
aws s3 ls --profile ygn-admin

# Describe VPCs
aws ec2 describe-vpcs --region us-east-1 --profile mdy-admin

# List IAM roles
aws iam list-roles --profile mdy-admin
```


```
vagrant@cloud-native-box:~/aws-multi-account-terraform/terraform$ aws ec2 describe-instances --region us-west-1 --profile ygn-admin
{
    "Reservations": []
}
vagrant@cloud-native-box:~/aws-multi-account-terraform/terraform$ aws s3 ls --profile ygn-admin
2023-10-23 06:58:41 aungkohtet-cloud-resume-challenge
vagrant@cloud-native-box:~/aws-multi-account-terraform/terraform$ aws ec2 describe-vpcs --region us-east-1 --profile mdy-admin
{
    "Vpcs": [
        {
            "CidrBlock": "172.31.0.0/16",
            "DhcpOptionsId": "dopt-05f5df9bd3b4241ca",
            "State": "available",
            "VpcId": "vpc-096aafcefd4ebc7b7",
            "OwnerId": "789190439145",
            "InstanceTenancy": "default",
            "CidrBlockAssociationSet": [
                {
                    "AssociationId": "vpc-cidr-assoc-0e474437a8cedff68",
                    "CidrBlock": "172.31.0.0/16",
                    "CidrBlockState": {
                        "State": "associated"
                    }
                }
            ],
            "IsDefault": true
        },
        {
            "CidrBlock": "10.0.0.0/16",
            "DhcpOptionsId": "dopt-05f5df9bd3b4241ca",
            "State": "available",
            "VpcId": "vpc-01341e674bc664404",
            "OwnerId": "789190439145",
            "InstanceTenancy": "default",
            "CidrBlockAssociationSet": [
                {
                    "AssociationId": "vpc-cidr-assoc-04bfbb4302c473a7d",
                    "CidrBlock": "10.0.0.0/16",
                    "CidrBlockState": {
                        "State": "associated"
                    }
                }
            ],
            "IsDefault": false,
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "my-vpc"
                },
                {
                    "Key": "Terraform",
                    "Value": "true"
                },
                {
                    "Key": "Environment",
                    "Value": "dev"
                }
            ]
        }
    ]
}
(END)
^C
vagrant@cloud-native-box:~/aws-multi-account-terraform/terraform$ 
```
