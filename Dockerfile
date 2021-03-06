FROM python:3.6

# Install CMake
RUN apt-get -qq update && \
    apt-get -qq install cmake && \
    apt-get -y clean all && \
    apt-get -y autoclean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN git clone https://github.com/eliasmarkc/girder /girder --recurse-submodules -b add-agave-support
WORKDIR /girder
RUN pip install -r requirements-dev.txt --no-cache-dir && \
    pip install flake8 coverage --no-cache-dir

ENV PYTHON="/usr/local/bin/python3" \
    COVERAGE="/usr/local/bin/coverage" \
    FLAKE8="/usr/local/bin/flake8"

COPY entrypoint.sh /
ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "" ]
