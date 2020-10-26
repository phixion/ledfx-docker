FROM alpine:latest
RUN apk add --no-cache curl
RUN apk add linux-headers 
RUN apk add --no-cache --update \
    git \
    bash \
    portaudio-dev \
    zlib-dev \
    libffi-dev \
    bzip2-dev \
    openssl-dev \
    readline-dev \
    sqlite-dev \
    build-base
ARG PYTHON_VERSION='3.7.0'
RUN export PYTHON_VERSION
ARG PYENV_HOME=/root/.pyenv
RUN export PYENV_HOME
RUN git clone --depth 1 https://github.com/pyenv/pyenv.git $PYENV_HOME && \
    rm -rfv $PYENV_HOME/.git
ENV PATH $PYENV_HOME/shims:$PYENV_HOME/bin:$PATH
RUN pyenv install $PYTHON_VERSION
RUN pyenv global $PYTHON_VERSION
RUN pip install --upgrade pip && pyenv rehash
RUN rm -rf ~/.cache/pip
RUN pip install cython && pip install ledfx
EXPOSE 8888
ENTRYPOINT ledfx --open-ui

