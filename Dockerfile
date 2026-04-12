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

# Compile all C++ sources and link against system libsqlite3
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
    -I./include \
    -I/usr/include/asio \
    -lsqlite3 \
    -lpthread \
    -o geoattend

EXPOSE 8080
CMD ["./geoattend"]
