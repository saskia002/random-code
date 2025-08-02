import os
import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin, unquote


base_url = ""

output_dir = "downloads"
os.makedirs(output_dir, exist_ok=True)

MAX_FILE_SIZE = 50 * 1024 * 1024  # 50 MB

def download_files(url, output_dir):
    # Fetch the directory listing
    response = requests.get(url)
    if response.status_code != 200:
        print(f"Failed to access {url}")
        return

    soup = BeautifulSoup(response.text, 'html.parser')

    for link in soup.find_all('a'):
        file_name = link.get('href')
        inner_text = link.text.strip()

        if not file_name or file_name in ['?C=N;O=D', '?C=M;O=A', '?C=S;O=A', '?C=D;O=A'] or inner_text == 'Parent Directory' or file_name.startswith('?'):
            continue

        decoded_file_name = unquote(file_name)

        # Handle files and subfolders separately
        if file_name.endswith('/'):  # It's a subfolder
            subfolder_name = decoded_file_name.rstrip('/')
            subfolder_path = os.path.join(output_dir, subfolder_name)
            os.makedirs(subfolder_path, exist_ok=True)
            subfolder_url = urljoin(url, file_name)
            print(f"Entering subfolder: {subfolder_url}")
            download_files(subfolder_url, subfolder_path)  # Recursive call
        else:  # It's a file
            file_url = urljoin(url, file_name)

            print(f"Checking size of {file_url}...")
            head_response = requests.head(file_url)
            file_size = int(head_response.headers.get('Content-Length', 0))

            if file_size > MAX_FILE_SIZE:
                print(f"Skipping {file_url} (Size: {file_size / (1024 * 1024):.2f} MB)")
                continue

            print(f"Downloading {file_url}...")
            file_response = requests.get(file_url)
            file_path = os.path.join(output_dir, decoded_file_name)
            with open(file_path, 'wb') as f:
                f.write(file_response.content)

download_files(base_url, output_dir)

print("Download completed.")
