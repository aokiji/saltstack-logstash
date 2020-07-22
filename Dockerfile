FROM debian:stretch
ARG python_version=py3
ARG salt_version=2019.2
RUN   apt-get update -y \
        && apt-get install -y curl gnupg2 \
        && curl -sL https://repo.saltstack.com/$python_version/debian/9/amd64/$salt_version/SALTSTACK-GPG-KEY.pub | apt-key add - \
        && echo "deb http://repo.saltstack.com/$python_version/debian/9/amd64/$salt_version stretch main" > /etc/apt/sources.list.d/saltstack.list \
        && apt-get update -y \
        && apt-get install -y salt-master \
        && rm -rf /var/lib/apt/lists/*
COPY master.conf /etc/salt/master
ENV SALT_TAG=$salt_version@$python_version
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
CMD ["test-logstash"]
