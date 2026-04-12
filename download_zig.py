import urllib.request
import zipfile
import os

zig_url = "https://ziglang.org/download/0.13.0/zig-windows-x86_64-0.13.0.zip"
zip_path = "e:/GeoAttend/zig.zip"
extract_dir = "e:/GeoAttend/"

print("Downloading Zig (C++ compiler)...")
urllib.request.urlretrieve(zig_url, zip_path)

print("Extracting Zig...")
with zipfile.ZipFile(zip_path, 'r') as zip_ref:
    zip_ref.extractall(extract_dir)

print("Done.")
