import urllib.request
import zipfile
import os
import shutil

print("Downloading ASIO...")
urllib.request.urlretrieve("https://github.com/chriskohlhoff/asio/archive/refs/tags/asio-1-30-2.zip", "asio.zip")

print("Extracting ASIO...")
with zipfile.ZipFile("asio.zip", "r") as z:
    z.extractall(".")

print("Moving ASIO headers...")
# Copy the asio directory and asio.hpp from asio-asio-1-30-2/asio/include to backend/include
src_include = "asio-asio-1-30-2/asio/include"
dest_include = "e:/GeoAttend/backend/include"

for item in os.listdir(src_include):
    s = os.path.join(src_include, item)
    d = os.path.join(dest_include, item)
    if os.path.isdir(s):
        if not os.path.exists(d):
            shutil.copytree(s, d)
    else:
        if not os.path.exists(d):
            shutil.copy2(s, d)

print("Done compiling ASIO headers.")
