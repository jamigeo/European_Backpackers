import json
import boto3
from decimal import Decimal

dynamodb = boto3.resource('dynamodb')

def lambda_handler(event, context):
    table = dynamodb.Table('http-crud-cities')

    data = event.get("body")    

    # if data is string, make it JSON
    if (isinstance(data, str)):
        data = json.loads(data)
        
    data = json.loads(json.dumps(data), parse_float=Decimal)
    
    dbResponse = table.put_item(Item= data)
    
    httpStatusCode = dbResponse['ResponseMetadata']['HTTPStatusCode']
    

    response = {
        "cookies" : ["cookie1", "cookie2"],
        "isBase64Encoded": "false",
        "statusCode": httpStatusCode,
        "headers": { 
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*' 
        },
        "body": "Successfully written to DB!"
    } 
      
    return response