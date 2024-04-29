from PIL import Image
import pytesseract
import boto3
import os

s3 = boto3.client('s3')

def handler(event, context):
    """
    event: {
        "key": "example.png"
    }
    """
    key = event["key"]
    bucket = os.environ['BUCKET']
    
    response = s3.get_object(Bucket=bucket, Key=key)
    img = Image.open(response['Body'])

    text = pytesseract.image_to_string(img)
    return {
        "text": text
    }