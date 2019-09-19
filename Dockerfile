FROM quay.io/feedyard/buildkite-remote-docker:0.2.0

LABEL maintainer=<nic.cheneweth@thoughtworks.com>

# package versions installed
ENV SETUPTOOLS_VERSION=41.2.0
ENV INSPEC_VERSION=4.16.0
ENV INVOKE_VERSION=1.3.0
ENV PYLINT_VERSION=2.3.1
ENV YAMLLINT_VERSION=1.17.0
ENV HADOLINT_VERSION=1.17.1

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/v3.8/main' >> /etc/apk/repositories && \
    echo 'http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk add --no-cache \
        openrc=0.41.2-r1 \
        docker=19.03.2-r0 \
        python3=3.7.4-r0 \
        ruby=2.5.5-r0 \
        ruby-bundler=2.0.2-r0 \
        ruby-bigdecimal=2.5.5-r0 \
        ruby-webrick=2.5.5-r0 \
        gnupg=2.2.16-r0 \
        jq=1.6_rc1-r1 && \
    apk --no-cache add --virtual build-dependencies \
        build-base=0.5-r1 \
        python3-dev=3.7.4-r0 \
        ruby-dev=2.5.5-r0 \
        libffi-dev=3.2.1-r6 \
        musl-dev=1.1.23-r3 \
        g++=8.3.0-r0 \
        gcc=8.3.0-r0 \
        make=4.2.1-r2 && \
        rc-update add docker boot && \
        python3 -m ensurepip && \
        rm -r /usr/lib/python*/ensurepip && \
        pip3 install --upgrade pip==19.2.3 && \
        if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
        rm -r /root/.cache

RUN pip install \
        setuptools==${SETUPTOOLS_VERSION} \
        invoke==${INVOKE_VERSION} \
        pylint==${PYLINT_VERSION} \
        yamllint==${YAMLLINT_VERSION} && \
    echo "gem: --no-document" > /etc/gemrc && \
    gem install \
        inspec-bin:${INSPEC_VERSION} && \
    curl -SLO https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-x86_64 && \
    chmod +x hadolint-Linux-x86_64 && \
    mv hadolint-Linux-x86_64 /usr/local/bin/hadolint && \
    gem cleanup && \
    rm -rf /usr/lib/ruby/gems/*/cache/* \
           /tmp/* && \
    apk del build-dependencies

COPY ./hooks/environment.sh /buildkite/hooks/environment.sh
RUN  chmod +x /buildkite/hooks/environment.sh

VOLUME /buildkite
WORKDIR /buildkite
ENTRYPOINT ["buildkite-agent"]
CMD ["start"]
