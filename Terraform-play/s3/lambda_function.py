import json
import boto3
from decimal import Decimal

def lambda_handler(event, context):

    dynamodb = boto3.resource('dynamodb')
    table_name = 'european-cities'
    table = dynamodb.Table(table_name)

    s3 = boto3.client('s3')

    bucket_name = 'uploads-3to-dynamo-db'
    file_name = 'cities-reduced.json'

    try:
        response = s3.get_object(Bucket=bucket_name, Key=file_name)
        json_data = json.loads(response['Body'].read().decode('utf-8'), parse_float=Decimal)
        
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f'Fehler beim Laden der JSON-Datei: {str(e)}')
        }

    for city in json_data['cities']:
        
        table.put_item(Item=city)

        response = {
            'statusCode': 200,
            'body': json.dumps('Daten wurden erfolgreich in DynamoDB geschrieben')
        }

    return response

        
        #city = json.loads(json.dumps(city), parse_float=Decimal)
        #dbResponse = table.put_item(Item=data)
        
        # if 'geography' in city and 'latitude' in city['geography'] and 'longitude' in city['geography']:
        #     latitude_decimal = Decimal(city['geography']['latitude'])
        #     longitude_decimal = Decimal(city['geography']['longitude'])
        
        # print(city)
        
        # city_data = {
        #     'name': city['name'],
        #     'country': city['country'],
        #     'population': Decimal(city['population']),
        #     'average_age': Decimal(city['average_age']),
        #     'area': Decimal(city['area']),
        #     'population_density': Decimal(city['population_density']),
        #     'districts': Decimal(city['districts']),
        #     'geography': {
        #         'latitude': latitude_decimal,
        #         'longitude': longitude_decimal
        #     },
        #     'coat_of_arms_image_path': city['coat_of_arms_image_path']
        # }
        # print(city_data)
        
        # table.put_item(Item=city_data)
        
        