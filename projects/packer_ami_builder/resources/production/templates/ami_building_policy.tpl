{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "NonResourceBasedReadOnlyPermissions",
            "Action": [
                "ec2:Describe*",
                "ec2:CreateKeyPair",
                "ec2:CreateSecurityGroup",
                "ec2:DeleteKeypair",
                "ec2:CreateImage",
                "ec2:CopyImage",
                "ec2:CreateSnapshot",
                "ec2:DeleteSnapshot",
                "ec2:RegisterImage",
                "ec2:CreateTags",
                "ec2:ModifyImageAttribute",
                "iam:GetInstanceProfiles",
                "iam:ListInstanceProfiles"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "IAMPassroleToInstance",
            "Action": [
                "iam:PassRole"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:iam::${account_id}:role/VPCLockDown"
        },
        {
            "Sid": "AllowInstanceActions",
            "Effect": "Allow",
            "Action": [
                "ec2:RebootInstances",
                "ec2:StopInstances",
                "ec2:TerminateInstances",
                "ec2:StartInstances",
                "ec2:AttachVolume",
                "ec2:DetachVolume"
            ],
            "Resource": "arn:aws:ec2:${region}:${account_id}:instance/*",
            "Condition": {
                "StringEquals": {
                    "ec2:InstanceProfile": "arn:aws:iam::${account_id}:instance-profile/VPCLockDown"
                }
            }
        },
        {
            "Sid": "EC2RunInstances",
            "Effect": "Allow",
            "Action": "ec2:RunInstances",
            "Resource": "arn:aws:ec2:${region}:${account_id}:instance/*",
            "Condition": {
                "StringEquals": {
                    "ec2:InstanceProfile": "arn:aws:iam::${account_id}:instance-profile/VPCLockDown"
                }
            }
        },
        {
            "Sid": "EC2RunInstancesSubnet",
            "Effect": "Allow",
            "Action": "ec2:RunInstances",
            "Resource": "arn:aws:ec2:${region}:${account_id}:subnet/*",
            "Condition": {
                "StringEquals": {
                    "ec2:vpc": "arn:aws:ec2:${region}:${account_id}:vpc/${vpc_id}"
                }
            }
        },
        {
            "Sid": "RemainingRunInstancePermissions",
            "Effect": "Allow",
            "Action": "ec2:RunInstances",
            "Resource": [
                "arn:aws:ec2:${region}:${account_id}:volume/*",
                "arn:aws:ec2:${region}::image/*",
                "arn:aws:ec2:${region}::snapshot/*",
                "arn:aws:ec2:${region}:${account_id}:network-interface/*",
                "arn:aws:ec2:${region}:${account_id}:key-pair/*",
                "arn:aws:ec2:${region}:${account_id}:security-group/*"
            ]
        },
        {
            "Sid": "EC2VpcNonresourceSpecificActions",
            "Effect": "Allow",
            "Action": [
                "ec2:DeleteNetworkAcl",
                "ec2:DeleteNetworkAclEntry",
                "ec2:DeleteRoute",
                "ec2:DeleteRouteTable",
                "ec2:AuthorizeSecurityGroupEgress",
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:RevokeSecurityGroupEgress",
                "ec2:RevokeSecurityGroupIngress",
                "ec2:DeleteSecurityGroup"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "ec2:vpc": "arn:aws:ec2:${region}:${account_id}:vpc/${vpc_id}"
                }
            }
        }
    ]
}
