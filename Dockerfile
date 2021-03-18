# Dockerfile for time2backup

FROM alpine:latest

ENV BRANCH=stable
ENV VERSION=1.9.0

# 1. Install dependencies
# 2. Download time2backup
# 3. Uncompress it
# 4. Prepare default configuration
RUN apk add --no-cache coreutils bash rsync openssh-client curl && \
    curl -o /tmp/time2backup.tgz https://time2backup.org/download/time2backup/$BRANCH/$VERSION/time2backup-$VERSION.tar.gz && \
    cd /opt && tar zxf /tmp/time2backup.tgz && cp -p /opt/time2backup/config/default.example.conf /opt/time2backup/config/default.conf && \
    sed -i 's|^.*default_config_directory =|default_config_directory = /config|' /opt/time2backup/config/default.conf

# install time2backup without error
RUN /opt/time2backup/time2backup.sh install || true

# install entrypoint
COPY entrypoint.sh /
RUN chown -R root:root /entrypoint.sh /opt/time2backup && chmod 755 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/time2backup"]
