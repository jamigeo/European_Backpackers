import json

# DynamoDB expects the so called: "marshalled" JSON format for the import from a s3 bucket. 
# This code grabs the standard JSON file and converts it to the required format.

def marshal_value(value):
    if isinstance(value, str):
        return { "S": value }
    elif isinstance(value, int) or isinstance(value, float):
        return { "N": str(value) }
    elif isinstance(value, dict):
        return { "M": marshal_dict(value) }
    elif isinstance(value, list):
        return { "L": [marshal_value(item) for item in value] }

def marshal_dict(input_dict):
    marshalled_dict = {}
    for key, value in input_dict.items():
        marshalled_dict[key] = marshal_value(value)
    return marshalled_dict

with open('European_Backpackers\european_cities.json', 'r', encoding='utf-8') as f:
    normal_json = json.load(f)

marshalled_json = marshal_dict(normal_json)

with open('European_Backpackers\marshalledEuropean_Cities.json', 'w') as f:
    json.dump(marshalled_json, f, indent=4)

print(marshalled_json)