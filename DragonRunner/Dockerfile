# Build the dragon runner
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
  git python3 python3-pip

# Install the Dragon-Runner
WORKDIR /opt
RUN git clone --depth=1 https://github.com/cmput415/Dragon-Runner.git

# We already use latest, so we should be alright
WORKDIR /opt/Dragon-Runner
RUN pip install colorama numpy flask flask_cors pytest
RUN pip install -t /usr/local/dragon-runner .

WORKDIR /

ENV PATH="/usr/local/dragon-runner/bin:$PATH"
ENV PYTHONPATH="/usr/local/dragon-runner:$PYTHONPATH"
