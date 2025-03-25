import requests
import concurrent.futures

URLS = ['url1', 'url2']
NUMTHREADS = 4
NUMTRIES = 1500

def fetch_url(URL):
    try:
        response = requests.get(URL)
        return response.status_code
    except requests.RequestException as e:
        return f"Error: {e}"


with concurrent.futures.ThreadPoolExecutor(max_workers=NUMTHREADS) as executor:
    for url in URLS:
        results = list(executor.map(lambda _: fetch_url(url), range(NUMTRIES)))
        print(f'{url}:', results)
