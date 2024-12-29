FROM mcr.microsoft.com/devcontainers/python:3.12

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y \
    ansible \
    ansible-lint \
    sshpass \
    git \
    curl \
    && apt-get clean

RUN pip install molecule pytest

