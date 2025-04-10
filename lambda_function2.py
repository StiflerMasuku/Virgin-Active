import json
import boto3

def lambda_handler(event, context):
    # Initialize SNS client
    print(event)
    sns = boto3.client('sns')
    
    # Extract the phone number and OTP from the event
    PhoneNumber = '+27612868142'#event['Details']['ContactData']['CustomerEndpoint']['Address']
    otp = event['Details']['ContactData']['Attributes']['otp']
    
    # Create the message to be sent
    message = f"Your verification code is {otp}"
    
    try:
        # Send the message via SNS
        response = sns.publish(
            PhoneNumber=PhoneNumber,
            Message=message
        )
        
        # Log the response for debugging
        print(f"SNS Response: {response}")
        
        # Return the response from SNS
        return {
            'statusCode': 200,
            'body': json.dumps({'messageId': response['MessageId']})
        }
    except Exception as e:
        # Log the error for debugging
        print(f"Error sending SNS message: {e}")
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }

# Example event for testing
# if __name__ == "__main__":
#     test_event = {
#         'phone_number': '+1234567890',
#         'otp': '123456'
#     }
    print(lambda_handler(test_event, None))