FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

# Install build tools + system ASIO + SQLite dev headers
RUN apt-get update && apt-get install -y \
    g++ \
    gcc \
    libasio-dev \
    libsqlite3-dev \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download Crow (header-only)
RUN wget -q https://github.com/CrowCpp/Crow/releases/download/v1.2.0/crow_all.h \
    -O /usr/include/crow.h

WORKDIR /app
COPY . /app

WORKDIR /app/backend

# Step 1: Compile sqlite3.c as plain C (not C++)
RUN gcc -c src/sqlite3.c -o sqlite3.o

# Step 2: Compile all C++ sources + link with sqlite3.o
RUN g++ -std=c++17 \
    -DASIO_STANDALONE \
    -DCROW_ENABLE_SSL=0 \
    main.cpp \
    src/AttendanceManager.cpp \
    src/DashboardManager.cpp \
    src/Database.cpp \
    src/GeoFence.cpp \
    src/NotificationManager.cpp \
    src/Person.cpp \
    src/Student.cpp \
    sqlite3.o \
    -I./include \
    -I/usr/include/asio \
    -lpthread \
    -o geoattend

EXPOSE 8080
CMD ["./geoattend"]
