from dotenv import load_dotenv
import os
import requests
import functools
import pandas as pd


load_dotenv()  # take environment variables from .env.

api_key = os.getenv('API_KEY')
api_access_token = os.getenv("API_ACCESS_TOKEN")

BASE_MOVIES_URL = 'https://api.themoviedb.org/3/movie'
LATEST_MOVIES_URL = f"{BASE_MOVIES_URL}/top_rated"
# LATEST_MOVIES_URL = f"{BASE_MOVIES_URL}/latest/"


def refresh_token(func):
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        try:
            print("Run if the access token hasn't expired")
            return func(*args, **kwargs)
        except requests.HTTPError as e:
            if e.response.status_code == 401 or e.response.status_code == 403:
                # Obtain new token
                print('obtain new token')
                new_token = api_access_token

                # new_token = obtain_new_token()

                # # Update token in the request headers
                headers = {}
                headers["Authorization"] = f'Bearer {new_token}'
                # Retry the request with the updated token
                response = func(*args, headers=headers, **kwargs)
                return response
            else:
                msg = f"An error occurred while calling {func.__name__} raise {e.__class__.__name__} with error: {e}"
                print(msg)
                raise

    return wrapper

def obtain_new_token():
    pass

@refresh_token
def get_latest_movies(url, headers={}):

    headers['Content-Type'] = 'application/json'

    response = requests.request(method="GET", url=url, headers=headers)
    
    response.raise_for_status()

    return response.json()

def get_df_latest_movies():
    lst_latest_movie_objs = get_latest_movies(url=LATEST_MOVIES_URL)

    df_latest_movies = pd.DataFrame.from_dict(lst_latest_movie_objs)

    print(df_latest_movies.head(20))

    return df_latest_movies

if __name__ == "__main__":
    get_df_latest_movies()