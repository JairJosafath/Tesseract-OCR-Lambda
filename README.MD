# Project: Lambda Function for Image Text Extraction with Tesseract OCR

This project provides a Python Lambda function packaged as a Docker image, enabling you to leverage the power of Tesseract OCR for image text extraction within AWS Lambda. By deploying this function, you gain the flexibility to customize its capabilities based on your specific requirements.

The best way to push this image to ECR is to use the pre-generated commands in the console. You can find this by going to the ECR repository and clicking on the "View push commands" button.

For lambda you add the bucket name in the environment variable 'BUCKET'. I set the memory to 10240 MB since it might need more resources to run Tesseract OCR. I also set the timeout to 30 seconds.

You can test the function by uploading an image to the S3 bucket and performing a test event in the Lambda console. 

```json

{
    "key": "example-image.jpg"
}

```

I will provide a cdk stack in the future to deploy the solution.