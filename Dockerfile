FROM buildpack-deps:stretch

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    DEBIAN_FRONTEND="noninteractive" \
    apt-get install -y --no-install-recommends \
    nodejs \
    xvfb \
    chromium=72.0.3626.122-1~deb9u1 \
    chromium-driver=72.0.3626.122-1~deb9u1 \
    libgconf-2-4 \
    openjdk-8-jre-headless \
    yarn \
    && rm -rf /var/lib/apt/lists/*

ENV DISPLAY :99
ENV CHROME_BIN /usr/bin/chromium

COPY entrypoint.sh /
RUN chmod a+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
