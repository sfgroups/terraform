https://8thlight.com/blog/mike-knepper/2021/05/11/minimally-privileged-terraform.html
https://www.bogotobogo.com/DevOps/Terraform/Terraform_AWS_sts_AssumeRole_Cross_Account.php
https://skundunotes.com/2021/09/26/strengthen-security-posture-with-terraform-and-aws-iam-to-manage-aws-cloud-resources/
https://meirg.co.il/2021/04/23/determining-aws-iam-policies-according-to-terraform-and-aws-cli/

* AWS Assume Role

1. Create User
2. Created Role
3. Update Role Trust Relationship
```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::123456788:<user name>"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

4. Generate user key
5. set enviroment varbile for awscli
6. Test using below: ( Thanks: https://stackoverflow.com/questions/55128348/execute-terraform-apply-with-aws-assume-role)

```

aws_credentials=$(aws sts assume-role --role-arn "arn:aws:iam::161601953804:role/grange_assume_role" --role-session-name "RoleSession1")

export AWS_ACCESS_KEY_ID=$(echo $aws_credentials|jq '.Credentials.AccessKeyId'|tr -d '"')
export AWS_SECRET_ACCESS_KEY=$(echo $aws_credentials|jq '.Credentials.SecretAccessKey'|tr -d '"')
export AWS_SESSION_TOKEN=$(echo $aws_credentials|jq '.Credentials.SessionToken'|tr -d '"')
```
7. Test with session key
