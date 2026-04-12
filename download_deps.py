import urllib.request
import zipfile
import os

print("Downloading Crow...")
urllib.request.urlretrieve("https://github.com/CrowCpp/Crow/releases/download/v1.2.0/crow_all.h", "e:/GeoAttend/backend/include/crow.h")

print("Downloading SQLite...")
urllib.request.urlretrieve("https://sqlite.org/2024/sqlite-amalgamation-3450200.zip", "sqlite.zip")

print("Extracting SQLite...")
with zipfile.ZipFile("sqlite.zip", "r") as z:
    z.extractall(".")

print("Moving SQLite files...")
os.rename("sqlite-amalgamation-3450200/sqlite3.h", "e:/GeoAttend/backend/include/sqlite3.h")
os.rename("sqlite-amalgamation-3450200/sqlite3.c", "e:/GeoAttend/backend/src/sqlite3.c")

print("Done.")
