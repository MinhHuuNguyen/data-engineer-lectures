import requests
import jwt
import time
import functools

# Define constants
SERVER_URL = "https://example.com/movies"
TOKEN_URL = "https://example.com/token"
SECRET_KEY = "mysecretkey"

# Define the decorator function
def refresh_token_if_expired(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        try:
            # Get the access token from the function arguments
            access_token = kwargs['access_token']

            # Decode token to get its expiration time
            payload = jwt.decode(access_token, SECRET_KEY, algorithms=['HS256'])
            exp = payload['exp']

            # Check if token has expired
            if exp <= time.time():
                # If token has expired, make a request to refresh it
                headers = {'Authorization': f'Bearer {refresh_token}'}
                response = requests.post(TOKEN_URL, headers=headers)
                new_token = response.json()['access_token']

                # Update the access_token argument with the new token
                kwargs['access_token'] = new_token

            # Call the original function with the updated argument
            return func(*args, **kwargs)

        except jwt.exceptions.InvalidTokenError:
            # If token is invalid, raise an error
            raise ValueError('Invalid token')

    return wrapper


# Define the main function
@refresh_token_if_expired
def get_latest_movies(access_token):
    headers = {'Authorization': f'Bearer {access_token}'}
    response = requests.get(SERVER_URL, headers=headers)
    return response.json()


# Example usage
access_token = "myaccesstoken"
latest_movies = get_latest_movies(access_token)
print(latest_movies)