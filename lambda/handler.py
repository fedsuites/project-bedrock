import json
import logging
import urllib.parse

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):
    """
    Lambda function triggered by S3 object uploads.
    Logs the name of the uploaded file to CloudWatch.
    """
    logger.info("Lambda triggered by S3 event")

    for record in event.get("Records", []):
        bucket = record["s3"]["bucket"]["name"]
        key = urllib.parse.unquote_plus(
            record["s3"]["object"]["key"],
            encoding="utf-8"
        )
        logger.info(f"Image received: {key}")
        logger.info(f"Bucket: {bucket}")
        logger.info(f"Full event record: {json.dumps(record)}")

    return {
        "statusCode": 200,
        "body": json.dumps("File processed successfully")
    }