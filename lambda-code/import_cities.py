import json
import boto3
from decimal import Decimal

def lambda_handler(event, context):

    dynamodb = boto3.resource('dynamodb')
    table_name = 'european-cities'
    table = dynamodb.Table(table_name)

    s3 = boto3.client('s3')

    bucket_name = 'projekt-eb'
    file_name = 'european-cities-list.json'

    try:
        response = s3.get_object(Bucket=bucket_name, Key=file_name)
        json_data = json.loads(response['Body'].read().decode('utf-8'), parse_float=Decimal)
        
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f'Fehler beim Laden der JSON-Datei: {str(e)}')
        }

    # for city in json_data['cities']:
    for city in json_data:
        
        table.put_item(Item=city)

        response = {
            'statusCode': 200,
            'body': json.dumps('Daten wurden erfolgreich in DynamoDB geschrieben')
        }

    return response
