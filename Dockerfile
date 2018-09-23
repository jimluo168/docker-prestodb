FROM registry.advanpro.cn/hadoop-base:2.0.0-hadoop2.7.7-java8
MAINTAINER luojimeng <luojimeng@advanpro.hk>

ENV PRESTO_VERSION=0.211
ENV PRESTO_HOME=/opt/presto

RUN curl -L https://repo1.maven.org/maven2/com/facebook/presto/presto-server/${PRESTO_VERSION}/presto-server-${PRESTO_VERSION}.tar.gz -o /tmp/presto-server.tgz && \
    tar -xzf /tmp/presto-server.tgz -C /opt && \
    ln -s /opt/presto-server-${PRESTO_VERSION} ${PRESTO_HOME} && \
    mkdir -p ${PRESTO_HOME}/data && \
    rm -f /tmp/presto-server.tgz

# COPY presto-server-${PRESTO_VERSION}.tar.gz /tmp/presto-server.tgz

RUN apt-get update && \
    apt-get install -y python && \
    apt-get update && \
    tar -xzf /tmp/presto-server.tgz -C /opt && \
    ln -s /opt/presto-server-${PRESTO_VERSION} ${PRESTO_HOME} && \
    mkdir -p ${PRESTO_HOME}/data && \
    rm -f /tmp/presto-server.tgz

COPY etc ${PRESTO_HOME}/etc
EXPOSE 8080

VOLUME ["${PRESTO_HOME}/etc", "${PRESTO_HOME}/data"]

WORKDIR ${PRESTO_HOME}

ENTRYPOINT ["./bin/launcher"]

CMD ["run"]
