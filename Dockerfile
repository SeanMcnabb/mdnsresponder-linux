FROM ubuntu
LABEL description="ubuntu build ENV"
RUN apt-get update && apt-get -y --no-install-recommends install \
    g++ \
    cmake \ 
    build-essential \
    wget
