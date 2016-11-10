{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "iam:*AccessKey*",
                "iam:*LoginProfile",
                "iam:*SSHPublicKey*",
                "iam:ListAttachedUserPolicies",
                "iam:ListSigningCertificates",
                "iam:ListUserPolicies"
            ],
            "Resource": "arn:aws:iam::${account_id}:user/users/$${aws:username}"
        },
        {
            "Effect": "Allow",
            "Action": [
                "iam:GetAccountPasswordPolicy",
                "iam:GetAccountSummary",
                "iam:ListAccount*",
                "iam:ListAttachedGroupPolicies",
                "iam:ListGroups",
                "iam:ListGroupsForUser",
                "iam:ListUsers"
            ],
            "Resource": "*"
        },
        {
            "Sid": "AllowUsersToCreateEnableResyncDeleteTheirOwnVirtualMFADevice",
            "Effect": "Allow",
            "Action": [
                "iam:CreateVirtualMFADevice",
                "iam:DeleteVirtualMFADevice",
                "iam:EnableMFADevice",
                "iam:ResyncMFADevice"
            ],
            "Resource": [
                "arn:aws:iam::${account_id}:mfa/$${aws:username}",
                "arn:aws:iam::${account_id}:user/users/$${aws:username}"
            ]
        },
       {
            "Sid": "AllowUsersToDeactivateTheirOwnVirtualMFADevice",
            "Effect": "Allow",
            "Action": [
                "iam:DeactivateMFADevice"
            ],
            "Resource": [
                "arn:aws:iam::${account_id}:mfa/$${aws:username}",
                "arn:aws:iam::${account_id}:user/users/$${aws:username}"
            ],
            "Condition": {
                "Bool": {
                    "aws:MultiFactorAuthPresent": true
                }
            }
        },
        {
            "Sid": "AllowUsersToListMFADevicesandUsersForConsole",
            "Effect": "Allow",
            "Action": [
                "iam:ListMFADevices",
                "iam:ListUsers",
                "iam:ListVirtualMFADevices"
            ],
            "Resource": "*"
        }
    ]
}
