import boto3
import urllib
import re
import uuid
from botocore.exceptions import ClientError

S3 = boto3.client('s3')

REQUEST_ID_REGEX = re.compile(r'data-govuk-request-id=(?:3D){,1}"([0-9\-\.]+)"')

def lambda_handler(event, context):
    bucket_name = source_bucket_name(event)
    key = source_key(event)
    request_id = parse_request_id(bucket_name, key)
    prefix = file_prefix(event, request_id)
    move_file(bucket_name, key, request_id, prefix)

def source_bucket_name(event):
    return event['Records'][0]['s3']['bucket']['name']

def source_key(event):
    return urllib.unquote_plus(event['Records'][0]['s3']['object']['key']).decode('utf8')

def parse_request_id(bucket_name, key):
    m = REQUEST_ID_REGEX.search(email_body(bucket_name, key))
    if m:
        return m.group(1)

def email_body(bucket_name, key):
    response = S3.get_object(Bucket=bucket_name, Key=key)
    return response["Body"].read()

def move_file(bucket_name, key, request_id, prefix):
    S3.copy_object(
        Bucket=bucket_name,
        CopySource='%s/%s' % (bucket_name, key),
        Key='%s/%s.msg' % (prefix, request_id or uuid.uuid4()))
    S3.delete_object(Bucket=bucket_name, Key=key)

def file_prefix(event, request_id):
    if request_id:
        return "travel-advice-alerts"
    else:
        return "no-request-id"
