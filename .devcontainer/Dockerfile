FROM mcr.microsoft.com/devcontainers/python:3.12

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y \
    sshpass \
    git \
    curl \
    && apt-get clean

WORKDIR /workspace
