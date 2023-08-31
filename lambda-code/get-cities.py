import json
import boto3

def lambda_handler(event, context):
    
    client = boto3.client('dynamodb')
    
    data = client.scan(
        TableName='http-crud-cities'
        )

    response = {
        'statusCode': 200,
        'body': json.dumps(data),
        'headers': {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*'
        },
    }
  
    return response