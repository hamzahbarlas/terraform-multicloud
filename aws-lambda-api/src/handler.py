import json
from datetime import datetime, timezone


def handler(event, context):
    return {
        "statusCode": 200,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps({
            "message": "Hello from AWS Lambda",
            "timestamp": datetime.now(timezone.utc).isoformat(),
        }),
    }
