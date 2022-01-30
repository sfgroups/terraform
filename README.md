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
