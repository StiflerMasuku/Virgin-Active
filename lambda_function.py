import json
import boto3
from boto3.dynamodb.conditions import Key
import random

def generate_otp():
    return str(random.randint(10000, 99999))

def lambda_handler(event, context):
    # Initialize DynamoDB resource
    print(event)
    dynamodb = boto3.resource('dynamodb')
    
    # Replace 'YourTableName' with your DynamoDB table name
    table = dynamodb.Table('DynamoContactCenter')
    
    # Extract phone number from the Amazon Connect event
    phone_number = event['Details']['ContactData']['CustomerEndpoint']['Address']
    
    # Query DynamoDB to check if the phone number exists
    response = table.query(
        KeyConditionExpression=Key('PhoneNumber').eq(phone_number)
    )
    
    if response['Items']:
        # Phone number exists, return the associated state
        state = response['Items'][0]['State']
        otp = response['Items'][0]['OTP']
    else:
        # Phone number does not exist, generate new OTP and set default state
        otp = generate_otp()
        state = 'Open'  # Default state if not found
        table.put_item(
            Item={
                'PhoneNumber': phone_number,
                'OTP': otp,
                'State': state
            }
        )
    
    return {
        'statusCode': 200,
        'state': state,
        'otp': otp,
        'PhoneNumber': phone_number
    }

# Example event for testing
if __name__ == "__main__":
    test_event = {
        'Details': {
            'ContactData': {
                'CustomerEndpoint': {
                    'Address': '+27612868142'
                }
            }
        }
    }
    print(lambda_handler(test_event, None))