import json
import boto3
from boto3.dynamodb.conditions import Attr

def lambda_handler(event, context):
    # Initialize DynamoDB resource
    dynamodb = boto3.resource('dynamodb')
    
    # Replace 'YourTableName' with your DynamoDB table name
    table = dynamodb.Table('DynamoContactCenter')
    
    try:
        # Scan the table to find all items with state 'Open' or 'Closed'
        response = table.scan(
            FilterExpression=Attr('State').eq('Open') | Attr('State').eq('Closed')
        )
        
        updated_items = []
        
        # Update the state of each item
        for item in response['Items']:
            new_state = 'Closed' if item['State'] == 'Open' else 'Open'
            update_response = table.update_item(
                Key={
                    'PhoneNumber': item['PhoneNumber']
                },
                UpdateExpression="set #s = :new_state",
                ExpressionAttributeNames={
                    '#s': 'State'
                },
                ExpressionAttributeValues={
                    ':new_state': new_state
                },
                ReturnValues="UPDATED_NEW"
            )
            updated_state = update_response['Attributes']['State']
            updated_items.append({
                'PhoneNumber': item['PhoneNumber'],
                'State': updated_state
            })
            
            # Log the updated state on its own
            print(f"Updated State for PhoneNumber {item['PhoneNumber']}: {updated_state}")
        
        # Log the response for debugging
        print(f"DynamoDB Update Response: {updated_items}")
        
        # Return the updated states
        return {
            'statusCode': 200,
            'body': json.dumps({'updatedItems': updated_items})
        }
    except Exception as e:
        # Log the error for debugging
        print(f"Error updating state: {e}")
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }

# Example event for testing
if __name__ == "__main__":
    test_event = {}
    print(lambda_handler(test_event, None))